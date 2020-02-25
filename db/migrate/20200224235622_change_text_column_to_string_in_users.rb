class ChangeTextColumnToStringInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :suburb, :string
  end
end
