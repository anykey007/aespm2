class AddUserIdToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :user_id, :integer
    Company.all.each do |company|
      company.update_column(:user_id, 1)
    end
  end
end
