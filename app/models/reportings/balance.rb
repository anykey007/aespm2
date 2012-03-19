class Reportings::Balance < Report
  def lines
    ReportingForms::BalanceLine.all
  end

  attr_accessor :code_230, :code_240, :code_260, :code_280, :code_380, :code_480, :code_620


  after_initialize do |balance|
    balance.code_230 = values.by_code("230").first if !values.by_code("230").first.nil?
    balance.code_240 = values.by_code("240").first if !values.by_code("240").first.nil?
    balance.code_260 = values.by_code("260").first if !values.by_code("260").first.nil?
    balance.code_280 = values.by_code("280").first if !values.by_code("280").first.nil?
    balance.code_380 = values.by_code("380").first if !values.by_code("380").first.nil?
    balance.code_480 = values.by_code("480").first if !values.by_code("480").first.nil?
    balance.code_620 = values.by_code("620").first if !values.by_code("620").first.nil?
  end

#  def code_230
#    values.by_code("230").first if !values.by_code("230").first.nil?
#  end
#
#  def code_240
#    values.by_code("240").first if !values.by_code("240").first.nil?
#  end
#
#  def code_260
#    values.by_code("260").first if !values.by_code("260").first.nil?
#  end
#
#  def code_280
#    values.by_code("280").first if !values.by_code("280").first.nil?
#  end
#
#  def code_380
#    values.by_code("380").first if !values.by_code("380").first.nil?
#  end
#
#  def code_480
#    values.by_code("480").first if !values.by_code("480").first.nil?
#  end
#
#  def code_620
#    values.by_code("620").first if !values.by_code("620").first.nil?
#  end

end
