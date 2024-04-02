class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.text :name, null: false, index: true
      t.text :description, default: nil
      t.references :product_category, index: true
      t.text :product_image_url, default: nil
      t.text :product_url, default: nil
      t.json :properties, default: nil
      t.float :rating, default: 0, index: true
      t.float :price, default: 0, index: true
      t.string :provider, default: nil, index: true
      t.timestamps
    end
  end
end
