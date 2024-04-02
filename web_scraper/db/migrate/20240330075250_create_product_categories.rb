class CreateProductCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories do |t|
      t.text :name, default: nil, index: true
      t.string :provider, default: nil, index: true
      t.integer :total_products, default: 0
      t.timestamps
    end
  end
end
