class CreateBuyerMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :buyer_messages do |t|
      t.string :buyer_name
      t.string :buyer_email
      t.text :body
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
