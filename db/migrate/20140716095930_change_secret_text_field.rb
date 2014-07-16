class ChangeSecretTextField < ActiveRecord::Migration
  def change
    rename_column :users, :secret_text, :secret_code
  end
end
