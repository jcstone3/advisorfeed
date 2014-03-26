class RemoveDescriptionFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :description
  end
end
