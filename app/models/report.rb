# encoding: utf-8
class Report < ActiveRecord::Base

  belongs_to :company
  has_many :values, :class_name => "Value", :dependent => :destroy
  accepts_nested_attributes_for :values, :allow_destroy => true
  validates_uniqueness_of :company_id, :scope => [:type, :period], :message => "Для указаного периода уже существует запись"

  def copy_to(date)
    new_report = type.constantize.new
    new_report.company_id = company_id
    new_report.period = date
    rnd = Random.new
    values.each do |elem|
      value1=(elem.value1*rnd.rand(0.9 .. 1.1)).round(0)
      value2=(elem.value2*rnd.rand(0.9 .. 1.1)).round(0)
      value3=(elem.value3*rnd.rand(0.9 .. 1.1)).round(0)
      value4=(elem.value4*rnd.rand(0.9 .. 1.1)).round(0)
#      if elem.report.type=='Reportings::Labor' && (elem.line.code=='1010' || elem.line.code=='1040')
#        value1 = value1.round(0)
#        value2 = value2.sround(0)
#        value3 = value3.round(0)
#        value4 = value4.round(0)
#      end
      new_report.values.build(:line_id=>elem.line_id,
                              :value1=>value1,
                              :value2=>value2,
                              :value3=>value3,
                              :value4=>value4
      )
    end
    new_report.save_and_update_parents
#    puts new_report.values.inspect
  end

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
    line_values = values.sort_by { |obj| obj.line.parents_count }.reverse
    line_values.each do |line_value|
      if line_value.line.childs.size>0
        child_ids = line_value.line.childs.pluck('id')
        value1, value2 = 0, 0
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
