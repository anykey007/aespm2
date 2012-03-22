# encoding: utf-8
class Report < ActiveRecord::Base

  belongs_to :company
  has_many :values, :class_name => "Value", :dependent => :destroy
  accepts_nested_attributes_for :values, :allow_destroy => true
  validates_uniqueness_of :company_id, :scope => [:type, :period], :message => "Для указаного периода уже существует запись"


  def save_and_update_parents
    self.save!
    self.update_parent_in_values
    self.update_total_values
  end

  def update_attributes_and_update_parents(params)
    self.update_attributes(params)
    self.update_parent_in_values
    self.update_total_values
  end



  def update_parent_in_values
    line_values = values.sort_by{|obj| obj.line.parents_count}.reverse
    line_values.each do |line_value|
      if line_value.line.childs.size>0
        child_ids = line_value.line.childs.pluck('id')
        value1, value2 = 0,0
        values.childs(child_ids).each do |val|
           value1 = value1+val.real_value1
          value2 = value2+val.real_value2
        end
#        value1 = values.childs(child_ids).sum('value1')
#        value2 = values.childs(child_ids).sum('value2')
        line_value.update_column(:value1, value1)
        line_value.update_column(:value2, value2)
      end
    end
  end
  def update_total_values
    line_values = values.totals
    line_values.each do |line_value|
        line_value.update_column(:value1, line_value.parent.value1)
        line_value.update_column(:value2, line_value.parent.value2)
    end
  end
end
