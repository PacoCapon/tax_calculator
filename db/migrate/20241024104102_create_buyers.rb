class CreateBuyers < ActiveRecord::Migration[7.2]
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :buyer_type
      t.string :country

      t.timestamps
    end
  end
end
