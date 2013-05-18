# encoding: utf-8
class Company < ActiveRecord::Base
  belongs_to :user
  has_many :balances, :class_name => "Reportings::Balance", :dependent => :destroy
  has_many :plans, :class_name => "Reportings::Plan", :dependent => :destroy
  has_many :labors, :class_name => "Reportings::Labor", :dependent => :destroy
  has_many :finresults, :class_name => "Reportings::Finresult", :dependent => :destroy
  has_many :b1s, :class_name => "Reportings::B1", :dependent => :destroy
  has_many :tanimotos, :class_name => "Reportings::Tanimoto", :dependent => :destroy

  scope :group1, where('state_share = 100')
  scope :group2, where('state_share >= 75 and state_share < 100')
  scope :group3, where('state_share >= 50 and state_share < 75')
  scope :group4, where('state_share >= 25 and state_share < 50')
  scope :group5, where('state_share >= 10 and state_share < 25')
  scope :group6, where('state_share >= 0 and state_share < 10')

  def generate_reports(start_period, end_period)
    while start_period <= end_period
      balances.last.copy_to(start_period)
      finresults.last.copy_to(start_period)
      labors.last.copy_to(start_period)
      plans.last.copy_to(start_period)
      start_period+=3.month
    end
  end

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
