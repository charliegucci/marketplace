class AddApplicationStatusToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :application_status, :string, null: false, default: "not_applied"
  end
end
