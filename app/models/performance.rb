#encoding: utf-8
class Performance
  def initialize(company,period)
    @company = Company.find(company)
    @period = period
    @balance = @company.balances.order('period desc').where('period <= ?',@period).limit(1).first
    @labor = @company.labors.order('period desc').where('period <= ?',@period).limit(1).first
    @finresult = @company.finresults.order('period desc').where('period <= ?',@period).limit(1).first
    @plan = @company.plans.order('period desc').where('period <= ?',@period).limit(1).first
  end

  attr_accessor :company, :period, :balance, :labor, :finresult, :plan


  def assessment
    count_all = 13.0
    count_bingo = 0.0
    count_bingo+=1 if normal_total_wage_arrears?
    count_bingo+=1 if normal_social_charges?
    count_bingo+=1 if normal_net_profit?
    count_bingo+=1 if normal_net_profit_or_loss?
    count_bingo+=1 if normal_part_dividendiv_accrued_on_shares?
    count_bingo+=1 if normal_part_net_income_is_transferred_to_the_state_budget?
    count_bingo+=1 if normal_rate_of_return_of?
    count_bingo+=1 if normal_absolute_liquidity_ratio?
    count_bingo+=1 if normal_ratio_of_own_funds?
    count_bingo+=1 if normal_ratio_of_total_liquidity?
    count_bingo+=1 if normal_ratio_coating?
    count_bingo+=1 if normal_ratio_of_financial_stability?
    count_bingo+=1 if normal_ratio_return_on_assets?


    result = count_bingo/count_all
    case result
      when 0.75..1
        return 'ефективне'
      when 0.5..0.74
        return 'задовільне'
      when 0.0..0.49
        return 'неефективне'
    end

  end

  def normal_total_wage_arrears?
    total_wage_arrears == 0
  end

  def normal_social_charges?
    social_charges > 0
  end

  def normal_net_profit?
    net_profit > 0
  end

  def normal_net_profit_or_loss?
    net_profit_or_loss > 0
  end

  def normal_part_dividendiv_accrued_on_shares?
    part_dividendiv_accrued_on_shares > 0
  end

  def normal_part_net_income_is_transferred_to_the_state_budget?
    part_net_income_is_transferred_to_the_state_budget > 0
  end

  def normal_rate_of_return_of?
    rate_of_return_of > 0.01
  end

  def normal_absolute_liquidity_ratio?
    absolute_liquidity_ratio >= 0.2 && absolute_liquidity_ratio <=0.35
  end

  def normal_ratio_of_own_funds?
    ratio_of_own_funds > 0.1
  end

  def normal_ratio_of_total_liquidity?
    ratio_of_total_liquidity >= 0.2 && ratio_of_total_liquidity <=0.35
  end

  def normal_ratio_coating?
    ratio_coating > 1
  end

  def normal_ratio_of_financial_stability?
    ratio_of_financial_stability > 1
  end

  def normal_ratio_return_on_assets?
    ratio_return_on_assets > 0
  end


  # Некомерційні показники

  # Середньооблікова кількість штатних працівників
  # Форма № 1-ПВ "Звіт з праці" (термінова – місячна), рядок 1040, графа 2
  def average_number_of_staff
    (!@labor.nil? && !@labor.code_1040.nil?) ?
        @labor.code_1040.value2 :  nil
  end

  # Середня заробітна плата
  # Форма № 1-ПВ "Звіт з праці" (термінова – місячна), рядок 1070, графа 2, рядок 1040, графа 2
  # Порядок розрахунку:  рядок 1070, графа 2 / рядок 1040, графа 2
  def average_salary
   (!@labor.nil? && !@labor.code_1040.nil? && !average_number_of_staff.nil? && average_number_of_staff.nonzero?) ?
#       @labor.code_1070.value2/average_number_of_staff : nil
      @labor.code_1070.value2 : nil
  end

  # Сума заборгованості із заробітної плати
  # Форма № 1-ПВ "Звіт з праці" (термінова – місячна), рядок 2010, графа 1
  def total_wage_arrears
    (!@labor.nil? && !@labor.code_2010.nil?) ? @labor.code_2010.value1 : nil
  end

  # Відрахування на соціальні заходи
  # Форма № 2 "Звіт про фінансові результати", рядок 250, графа 3
  # II. ЕЛЕМЕНТИ ОПЕРАЦІЙНИХ ВИТРАТ
  def social_charges
    (!@finresult.nil? && @finresult.code_250) ? @finresult.code_250.value1 : nil
  end


  # Комерційні показники

  # Чистий дохід (виручка) від реалізації продукції (товарів, робіт, послуг)
  # Форма № 2 "Звіт про фінансові результати", рядок 035, графа 3
  def net_profit
    (!@finresult.nil? && @finresult.code_035) ? @finresult.code_035.value1 : nil
  end

  # Чистий прибуток (збиток)
  # Форма № 2 "Звіт про фінансові результати", рядок 220 (225), графа 3
  def net_profit_or_loss
     (!@finresult.nil?  && !@finresult.code_220.nil? && !@finresult.code_225.nil?) ?
         @finresult.code_220.value1-@finresult.code_225.value1 : nil
  end

  # Частина дівідендів, нарахованих на акції
  # Фінансовий план підприємства, розділ ІІ "Розподіл чистого прибутку", рядок 029/1
  def part_dividendiv_accrued_on_shares
     (!@plan.nil? && @plan.code_029) ? @plan.code_029.value2 : nil
  end

  # Частина чистого прибутку (доходу), що перераховується до державного бюджету
  # Фінансовий план підприємства, рядок 028
  def part_net_income_is_transferred_to_the_state_budget
     (!@plan.nil? && @plan.code_028) ? @plan.code_028.value2 : nil
  end


  # Показники фінансової діяльності
  # С БАЛАНСА

  # Коефіцієнт рентабельності діяльності
  # характеризує ефективність господарської діяльності підприємства 
  # форма № 2, рядок 220 (225) та рядок 035
  def rate_of_return_of
      (@finresult && net_profit_or_loss && !@finresult.code_035.nil? && @finresult.code_035.value1.nonzero?) ?
          net_profit_or_loss/@finresult.code_035.value1 : nil
  end

  def rate_of_return_of_to_chart
    [DateTime.parse( period.strftime("%Y/%m/%d")).to_i*1000, !rate_of_return_of.nil? ? rate_of_return_of.round(3) : 0 ]
  end

  # Коефіцієнт абсолютної ліквідності
  # характеризує частину поточних зобов'язань, яка може бути сплачена негайно
  # форма № 1, рядки 230, 240, 620, графа 4
  def absolute_liquidity_ratio
    (!@balance.nil? && !@balance.code_620.nil? && !@balance.code_230.nil? && !@balance.code_240.nil? && @balance.code_620.value2.nonzero?) ?
      (@balance.code_230.value2+@balance.code_240.value2)/@balance.code_620.value2 : nil
  end

  def absolute_liquidity_ratio_to_chart
    [DateTime.parse( period.strftime("%Y/%m/%d")).to_i*1000, !absolute_liquidity_ratio.nil? ? absolute_liquidity_ratio.round(3) : 0 ]
  end

  def self.absolute_liquidity_ratio_norm_min
    0.2
  end

  def self.absolute_liquidity_ratio_norm_max
    0.35
  end

  # Коефіцієнт забезпеченості власними коштами
  # форма № 1, рядки 260, 620
  # Норматив: більше 0,1
  def ratio_of_own_funds
    (!@balance.nil? && !@balance.code_620.nil? && !@balance.code_260.nil? && @balance.code_260.value2.nonzero?) ?
      (@balance.code_260.value2-@balance.code_620.value2)/@balance.code_260.value2 : nil
  end
  def ratio_of_own_funds_to_chart
    [DateTime.parse( period.strftime("%Y/%m/%d")).to_i*1000, !ratio_of_own_funds.nil? ? ratio_of_own_funds.round(3) : 0 ]
  end


  def self.ratio_of_own_funds_min
    0.1
  end

  # Коефіцієнт загальної ліквідності
  # форма № 1, рядки 260, 480, 620
  def ratio_of_total_liquidity
    (!@balance.nil? && !@balance.code_620.nil? && !@balance.code_260.nil? && !@balance.code_480.nil? && (@balance.code_620.value2+@balance.code_480.value2).nonzero?) ?
      (@balance.code_260.value2)/(@balance.code_480.value2+@balance.code_620.value2) : nil
  end

  def ratio_of_total_liquidity_to_chart
    [DateTime.parse( period.strftime("%Y/%m/%d")).to_i*1000, !ratio_of_total_liquidity.nil? ? ratio_of_total_liquidity.round(3) : 0 ]
  end


  # Коефіцієнт покриття
  # форма № 1, рядки 260, 620, графа 4
  def ratio_coating
    (!@balance.nil? && !@balance.code_620.nil? && !@balance.code_260.nil? && @balance.code_620.value2.nonzero?) ?
      @balance.code_260.value2/@balance.code_620.value2 : nil
  end

  def ratio_coating_to_chart
    [DateTime.parse( period.strftime("%Y/%m/%d")).to_i*1000, !ratio_coating.nil? ? ratio_coating.round(3) : 0 ]
  end

  def ratio_coating_normal
    1
  end

  # Коефіцієнт фінансової стійкості
  # характеризує співвідношення власних та позикових коштів і залежність підприємства від зовнішніх фінансових джерел 
  # форма № 1, рядки 380, 480, 620, графа 4
  # власний капітал / (довгострокові зобов'язання + поточні зобов'язання)
  def ratio_of_financial_stability
     (!@balance.nil? && !@balance.code_620.nil? && !@balance.code_380.nil? && !@balance.code_480.nil? && (@balance.code_620.value2+@balance.code_480.value2).nonzero?) ?
      (@balance.code_380.value2)/(@balance.code_480.value2+@balance.code_620.value2) : nil
  end

  def ratio_of_financial_stability_to_chart
    [DateTime.parse( period.strftime("%Y/%m/%d")).to_i*1000, !ratio_of_financial_stability.nil? ? ratio_of_financial_stability.round(3) : 0 ]
  end


  # Коефіцієнт рентабельності активів
  # Характеризує ефективність використання активів підприємства
  # форма № 2, рядок 220 (225), форма № 1, рядок 280, графи 3, 4
  # Більше 0
  def ratio_return_on_assets
     (!@balance.nil? && net_profit_or_loss && @balance.code_280 && (@balance.code_280.value1+@balance.code_280.value2).nonzero?) ?
         net_profit_or_loss/((@balance.code_280.value1+@balance.code_280.value2)/2) : nil
  end

  def ratio_return_on_assets_to_chart
    [DateTime.parse( period.strftime("%Y/%m/%d")).to_i*1000, !ratio_return_on_assets.nil? ? ratio_return_on_assets.round(3) : 0 ]
  end


  # Показники стану активів та інвестиційно-інноваційної діяльності

  # Активи
  # Форма № 1 "Баланс", рядок 280, графи 3, 4
  def ratio_assets
      (@balance && @balance.code_280) ?
         @balance.code_280.value2 : nil
  end

  # Власний капітал
  # Форма № 1 "Баланс", рядок 380, графи 3, 4
  def ratio_equity
      (@balance && @balance.code_380) ?
         @balance.code_380.value2 : nil
  end

  # Капітальні інвестиції
  # Фінансовий план підприємства, таблиця 2, сума рядків 001/1 — 001/6
  def capital_investment

  end

  # Дебіторська заборгованість
  # Статистична звітність: форма № 1-Б (ІІ розділ – річна, квартальна), рядок 010, графи 2 і 3
  def accounts_receivable

  end
  # Кредиторська заборгованість
  # Статистична звітність: форма № 1-Б (ІІ розділ – річна, квартальна), рядок 010, графи 3 і 4
  def payables

  end

  # Коефіцієнт зносу основних засобів
  # Форма № 1 "Баланс", рядки 031 та 032, графа 4
  def ratio_of_fixed_assets

  end


  def strfkvartal(per)
    per.year.to_s+"; #{per.month.to_i/3} квартал"
  end

end

