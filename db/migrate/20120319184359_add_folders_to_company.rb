class AddFoldersToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :EDRPOY, :string
    add_column :companies, :state_share, :float
    add_column :companies, :state_share_count, :integer
    add_column :companies, :SF, :string
    add_column :companies, :region, :integer
    add_column :companies, :management, :integer
    add_column :companies, :governing_body, :string
    add_column :companies, :in_the_management, :string
    add_column :companies, :type_of_business_entity, :string
    add_column :companies, :bankruptcy, :boolean
    add_column :companies, :form_of_shares, :string
    add_column :companies, :strategist, :string
    add_column :companies, :address, :string
    add_column :companies, :nominal_value_of_shares, :float
    add_column :companies, :nominal_value_of_all_shares, :float
    add_column :companies, :EDRPOY2, :string
    add_column :companies, :KVED, :string
    add_column :companies, :mailbox_index, :string
  end
end
