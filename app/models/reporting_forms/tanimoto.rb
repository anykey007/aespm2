class ReportingForms::Tanimoto < ActiveRecord::Base
	has_many :values, :class_name => "Value", :dependent => :destroy
end
