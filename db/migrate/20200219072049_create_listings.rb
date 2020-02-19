class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :breeder_prefix
      t.references :breed, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
