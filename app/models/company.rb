class Company < ActiveRecord::Base
  belongs_to :user
  has_many :balances, :class_name => "Reportings::Balance", :dependent => :destroy
  has_many :plans, :class_name => "Reportings::Plan", :dependent => :destroy
  has_many :labors, :class_name => "Reportings::Labor", :dependent => :destroy
  has_many :finresults, :class_name => "Reportings::Finresult", :dependent => :destroy
end
