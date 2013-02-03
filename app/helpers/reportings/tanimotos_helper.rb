# encoding: utf-8
module Reportings::TanimotosHelper
  def coef_prefix(coef)
    case coef
      when 0..0.3
        'ПБ'
      when 0.31..0.59
        'УП'
      when 0.6..1 
        'БП'
      else
        ''
    end
  end

  def report_checkbox(report, report_ids)
    checked = (report_ids && report_ids.include?(report.id.to_s)) ? true : false
    content_tag :span do
      check_box_tag("compare[report_ids[#{report.id}]]",report.id.to_s, checked)+
      report.period.strftime("%d.%m.%Y")
    end
  end
end
