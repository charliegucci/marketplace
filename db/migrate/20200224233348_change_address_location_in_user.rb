class ChangeAddressLocationInUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :location, :street_number_name
    rename_column :users, :address, :suburb
  end
end
