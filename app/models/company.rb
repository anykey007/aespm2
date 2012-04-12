# encoding: utf-8
class Company < ActiveRecord::Base
  belongs_to :user
  has_many :balances, :class_name => "Reportings::Balance", :dependent => :destroy
  has_many :plans, :class_name => "Reportings::Plan", :dependent => :destroy
  has_many :labors, :class_name => "Reportings::Labor", :dependent => :destroy
  has_many :finresults, :class_name => "Reportings::Finresult", :dependent => :destroy
  has_many :b1s, :class_name => "Reportings::B1", :dependent => :destroy

  def performances(start_period, end_period)
   performance_list = []
    while start_period <= end_period
      performance_list << Performance.new(id,start_period)
      start_period = start_period + 3.month
    end
    performance_list
  end

  def header_to_html
    result=''
    result<<'<table>'
    result<<'<tr>'
    result<<'<th>ЕДРПОУ</th>'
    result<<'<th>Название</th>'
    result<<'<th></th>'
    result<<'<th></th>'
    result<<'th></th>'
    result<<'</tr>'
    result<<'</table>'
    result
  end
end
