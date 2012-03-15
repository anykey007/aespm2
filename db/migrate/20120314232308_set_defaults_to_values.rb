class SetDefaultsToValues < ActiveRecord::Migration
  def change
    change_column :values, :value1, :float, :default => '0'
    change_column :values, :value2, :float, :default => '0'
    change_column :values, :value3, :float, :default => '0'
    change_column :values, :value4, :float, :default => '0'
    change_column :values, :value5, :float, :default => '0'
  end
end
