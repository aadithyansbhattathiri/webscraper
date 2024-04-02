# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :provider, :description, :product_image_url, :product_url, :properties, :rating, :product_category_id, :category, :price

  def category
    object.product_category.name
  end
end