class Value < ActiveRecord::Base
  belongs_to :report
  belongs_to :line, :class_name => "Line", :foreign_key => "line_id"
  belongs_to :tanimoto_line, :class_name => "ReportingForms::Tanimoto", :foreign_key => "line_id"
  scope :childs, lambda { |child_ids| joins(:line).where(:lines=>{:id=>child_ids}) }
  scope :totals, joins(:line).where(:lines=>{:total=>false})
  scope :by_code, lambda { |code| joins(:line).where(:lines=>{:code=>code}) }

  def parent
    self.class.where('line_id = ? and report_id=?', line.parent, report_id).first
  end

  def real_value1
    if self && line.sign_minus?
      value1*(-1)
    else
      value1
    end
  end

  def real_value2
    if self && line.sign_minus?
      value2*(-1)
    else
      value2
    end
  end

  def deviation
    if !value2.nil? && !value1.nil?
      result=(value2-value1).round(2)
      result>0 ? result = ('+'+result.to_s) : result
    end
  end

  def execution
    !value2.nil? && !value1.nil? && value2!=0 ? ((value2/value1).round(2)*100).to_s+" %" : " "
  end


#  before_save do |value|
#    if value && value.line.sign_minus?
#      value.value1=value.value1*(-1)
#    end
#  end
end
