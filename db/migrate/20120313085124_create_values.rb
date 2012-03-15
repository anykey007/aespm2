class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.integer :report_id
      t.integer :line_id
      t.float :value1
      t.float :value2
      t.float :value3
      t.float :value4
      t.float :value5

      t.timestamps
    end
  end
end
