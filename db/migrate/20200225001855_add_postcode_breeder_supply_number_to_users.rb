class AddPostcodeBreederSupplyNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postcode, :integer
    add_column :users, :breeder_supply_number, :integer
  end
end
