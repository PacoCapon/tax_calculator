class CreateBuyers < ActiveRecord::Migration[7.2]
  def change
    create_table :buyers do |t|
      t.string :country
      t.string :buyer_type

      t.timestamps
    end
  end
end
