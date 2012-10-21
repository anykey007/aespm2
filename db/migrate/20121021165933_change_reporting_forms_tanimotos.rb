class ChangeReportingFormsTanimotos < ActiveRecord::Migration
  def change
      change_column :reporting_forms_tanimotos, :question, :text
      change_column :reporting_forms_tanimotos, :answer1, :text
      change_column :reporting_forms_tanimotos, :answer2, :text 
  end
end
