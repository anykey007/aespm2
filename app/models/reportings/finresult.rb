class Reportings::Finresult < Report
  def lines
     ReportingForms::FinresultLine.all
  end

  attr_accessor :code_035, :code_220, :code_225, :code_250, :code_280


  after_initialize do |finresult|
    finresult.code_035 = values.by_code("035").first if !values.by_code("035").first.nil?
    finresult.code_220 = values.by_code("220").first if !values.by_code("220").first.nil?
    finresult.code_225 = values.by_code("225").first if !values.by_code("225").first.nil?
    finresult.code_250 = values.by_code("250").first if !values.by_code("250").first.nil?
    finresult.code_280 = values.by_code("280").first if !values.by_code("280").first.nil?
  end

#
#  def code_035
#    values.by_code("035").first.value2 if !values.by_code("035").first.nil?
#  end
#
#  def code_220
#    values.by_code("220").first.value2 if !values.by_code("220").first.nil?
#  end
#
#  def code_225
#    values.by_code("225").first.value2 if !values.by_code("225").first.nil?
#  end
#
#  def code_250
#    values.by_code("250").first.value2 if !values.by_code("250").first.nil?
#  end
#
#  def code_280
#    values.by_code("280").first.value2 if !values.by_code("280").first.nil?
#  end





end
