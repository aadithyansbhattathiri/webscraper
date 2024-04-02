# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_30_075258) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "product_categories", force: :cascade do |t|
    t.text "name"
    t.string "provider"
    t.integer "total_products", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_categories_on_name"
    t.index ["provider"], name: "index_product_categories_on_provider"
  end

  create_table "products", force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.bigint "product_category_id"
    t.text "product_image_url"
    t.text "product_url"
    t.json "properties"
    t.float "rating", default: 0.0
    t.float "price", default: 0.0
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name"
    t.index ["price"], name: "index_products_on_price"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
    t.index ["provider"], name: "index_products_on_provider"
    t.index ["rating"], name: "index_products_on_rating"
  end

end
