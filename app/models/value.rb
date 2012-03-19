class Value < ActiveRecord::Base
   belongs_to :report
   belongs_to :line, :class_name => "Line", :foreign_key => "line_id"
   scope :childs, lambda { |child_ids| joins(:line).where('lines.id in (?)', child_ids) }
   scope :totals, joins(:line).where('lines.total=1')
   scope :by_code, lambda { |code| joins(:line).where('lines.code =?', code) }

  def parent
     self.class.where('line_id = ? and report_id=?',line.parent,report_id).first
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


#  before_save do |value|
#    if value && value.line.sign_minus?
#      value.value1=value.value1*(-1)
#    end
#  end
end
