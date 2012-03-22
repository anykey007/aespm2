# encoding: utf-8
class FinresultsReport < Prawn::Document

  def set_rep(company, report)
    @company = Company.find(company)
    @report = @company.finresults.find(report)
  end

  attr_accessor :company, :report
  # ширина колонок
  Widths = [330, 70, 70, 70]
  # заглавия колонок
  Headers = ['Стаття', 'Код рядка', 'За звітний період', 'За попередній період']

  def row(line_name, line_code, value1, value2)
    row = [line_name, line_code, value1, value2]
    make_table([row]) do |t|
      t.column_widths = Widths
      t.cells.style :borders => [:left, :right], :padding => 2
    end
  end

  def to_pdf
    # привязываем шрифты
    font_families.update(
        "Verdana" => {
            :bold => "#{Rails.root}/fonts/verdanab.ttf",
            :italic => "#{Rails.root}/fonts/verdanai.ttf",
            :normal => "#{Rails.root}/fonts/verdana.ttf"})
    font "Verdana", :size => 10


    table([
              ["", "", "КОДИ"],
              ["", "Дата (рік, місяць, число)", ""],
              ["Підприємство #{@company.name}", "за ЄДРПОУ", ""],
              ["Територія #{@company.region}", "за КОАТУУ", ""],
              ["Форма власності #{@company.type_of_business_entity}", "за КФВ", ""],
              ["Орган державного управління #{@company.governing_body}", "за СПОДУ", ""],
              ["Галузь #{@company.region}", "за ЗКГНГ", ""],
              ["Вид економічної діяльності #{@company.region}", "за КВЕД", ""],
              ["Одиниця виміру: тис. грн.", "Контрольна сума", ""],
          ], :column_widths => [340, 100, 100])
    move_down(5)
    text "Адреса: #{company.address}"

    move_down(18)
    text "Звіт про фінансові результати", :size => 15, :style => :bold, :align => :center
    move_down(10)
    text "за  #{@report.period.strftime("%d.%m.%Y")}", :size => 15, :style => :bold, :align => :center


    move_down(18)
    # выборка записей
    @values = @report.values
    data = []
    items = @values.each do |item|
      data << row(item.line.name_for_select_tag, item.line.code, item.value1, item.value2)
    end

    head = make_table([Headers], :column_widths => Widths)
    table([[head], *(data.map { |d| [d] })], :header => true, :row_colors => %w[cccccc ffffff]) do
      row(0).style :background_color => '404C99', :text_color => 'ffffff'
      cells.style :borders => []
    end
    # добавим время создания внизу страницы

    repeat(:all, :dynamic => true) do
      draw_text "Сторінка #{page_number} из #{page_count}", :at => [450, -10]
    end

    creation_date = Time.zone.now.strftime("Звіт згенеровано %e %b %Y в %H:%M")
    go_to_page(page_count)
    move_down(710)
    text creation_date, :align => :right, :style => :italic, :size => 9

    render
  end

end