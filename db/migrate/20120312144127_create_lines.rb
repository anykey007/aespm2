class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name
      t.string :code
      t.integer :parent_id
      t.string :type

      t.timestamps
    end
  end
end
