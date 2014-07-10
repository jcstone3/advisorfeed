class AddSecretTextToUser < ActiveRecord::Migration
  def change
    add_column :users, :secret_text, :string
  end
end
