class Reportings::Labor < Report

  def lines
    ReportingForms::LaborLine.all
  end

  attr_accessor :code_1040, :code_1070, :code_2010


  after_initialize do |labor|
    labor.code_1040 = values.by_code("1040").first if !values.by_code("1040").first.nil?
    labor.code_1070 = values.by_code("1070").first if !values.by_code("1070").first.nil?
    labor.code_2010 = values.by_code("2010").first if !values.by_code("2010").first.nil?
  end

  after_save do |labor|
    logger.debug 'labor was saved'
  end


#  def code_1040
#    values.by_code("1040").first if !values.by_code("1040").first.nil?
#  end
#
#  def code_1070
#    values.by_code("1070").first if !values.by_code("1070").first.nil?
#  end
#
#  def code_2010
#    values.by_code("2010").first if !values.by_code("2010").first.nil?
#  end


end

