class AddStripePaymentIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_payment_id, :string
  end
end