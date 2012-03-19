class Performance
  def initialize(company,period)
    @company = Company.find(company)
    @period = period
    @balance = @company.balances.order('period desc').where('period <= ?',@period).limit(1).first
    @labor = @company.labors.order('period desc').where('period <= ?',@period).limit(1).first
    @finresult = @company.finresults.order('period desc').where('period <= ?',@period).limit(1).first
    @plan = @company.plans.order('period desc').where('period <= ?',@period).limit(1).first
  end

  attr_accessor :company, :period, :balance, :labor

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
       @labor.code_1070.value2/average_number_of_staff : nil
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

  # Коефіцієнт абсолютної ліквідності
  # характеризує частину поточних зобов'язань, яка може бути сплачена негайно
  # форма № 1, рядки 230, 240, 620, графа 4
  def absolute_liquidity_ratio
    (!@balance.nil? && !@balance.code_620.nil? && !@balance.code_230.nil? && !@balance.code_240.nil? && @balance.code_620.value2.nonzero?) ?
      (@balance.code_230.value2+@balance.code_240.value2)/@balance.code_620.value2 : nil
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

  def self.ratio_of_own_funds_min
    0.1
  end

  # Коефіцієнт загальної ліквідності
  # форма № 1, рядки 260, 480, 620
  def ratio_of_total_liquidity
    (!@balanc.nil? && !@balance.code_620.nil? && !@balance.code_260.nil? && !@balance.code_480.nil? && (@balance.code_620.value2+@balance.code_480.value2).nonzero?) ?
      (@balance.code_260.value2)/(@balance.code_480.value2+@balance.code_620.value2) : nil
  end

  # Коефіцієнт покриття
  # форма № 1, рядки 260, 620, графа 4
  def ratio_coating
    (!@balance.nil? && !@balance.code_620.nil? && !@balance.code_260.nil? && @balance.code_620.value2.nonzero?) ?
      @balance.code_260.value2/@balance.code_620.value2 : nil
  end

  def ratio_coating_normal
    1
  end

  # Коефіцієнт фінансової стійкості
  # характеризує співвідношення власних та позикових коштів і залежність підприємства від зовнішніх фінансових джерел 
  # форма № 1, рядки 380, 480, 620, графа 4
  # власний капітал / (довгострокові зобов'язання + поточні зобов'язання)
  def retio_of_financial_stability
     (!@balance.nil? && !@balance.code_620.nil? && !@balance.code_380.nil? && !@balance.code_480.nil? && (@balance.code_620.value2+@balance.code_480.value2).nonzero?) ?
      (@balance.code_380.value2)/(@balance.code_480.value2+@balance.code_620.value2) : nil
  end


  # Коефіцієнт рентабельності активів
  # Характеризує ефективність використання активів підприємства
  # форма № 2, рядок 220 (225), форма № 1, рядок 280, графи 3, 4
  # Більше 0
  def ratio_return_on_assets
     (@balance && net_profit_or_loss && (@balance.code_280.value1+@balance.code_280.value2).nonzero?) ?
         net_profit_or_loss/((@balance.code_280.value1+@balance.code_280.value2)/2) : nil
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



end
