class AddCompanyAndWebsiteToUser < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :website, :string
  end
end
