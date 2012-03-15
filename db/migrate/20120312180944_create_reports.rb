class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :company_id
      t.date :period
      t.string :type

      t.timestamps
    end
  end
end
