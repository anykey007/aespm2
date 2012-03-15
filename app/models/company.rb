class Company < ActiveRecord::Base
  has_many :balances, :class_name => "Reportings::Balance", :dependent => :destroy
  has_many :plans, :class_name => "Reportings::Plan", :dependent => :destroy
end
