class Line < ActiveRecord::Base
  has_many :childs, :class_name => "Line", :foreign_key => "parent_id", :conditions => {:total => false}
  belongs_to :parent, :class_name => "Line", :foreign_key => "parent_id"

  has_many :values, :class_name => "Value", :dependent => :destroy

  scope :without_line, lambda { |line_id| where(:id!=line_id, :total=>false) }


  validates_presence_of :name

  def disabled?
    self && (childs.size>0 || total)
  end

  def sign_plus?
    sign=='plus'
  end

  def sign_minus?
    sign=='minus'
  end

  def parents_count
    flag = true
    buf_line = self
    count = 0
    while flag do
      if !buf_line.parent.nil?
        count+=1
        buf_line=buf_line.parent
      else
        flag=false
      end
    end
    return count
  end

  def name_for_select_tag
    if self
      lines=parents_count
      if total && lines>1
        lines=lines-1
      end
      "--"*lines+name
    end
  end

  def name_for_table
    "--"*parents_count+name
  end
end
