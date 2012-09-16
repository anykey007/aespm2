class CreateReportingFormsTanimotos < ActiveRecord::Migration
  def change
    create_table :reporting_forms_tanimotos do |t|
      t.string :question
      t.string :answer1
      t.string :answer2

      t.timestamps
    end
  end
end
