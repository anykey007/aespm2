class AddTotalByPartToLines < ActiveRecord::Migration
  def change
    add_column :lines, :total, :boolean, :default=>false
    add_column :lines, :sign, :string, :default=>"plus"
  end
end
