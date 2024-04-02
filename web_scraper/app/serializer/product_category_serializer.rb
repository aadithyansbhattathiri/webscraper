# frozen_string_literal: true

class ProductCategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :provider, :total_products
end