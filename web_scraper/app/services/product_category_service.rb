# frozen_string_literal: true

class ProductCategoryService
  def initialize(category_details, provider)
    @category = category_details
    @provider = provider
  end

  def call
    product_category = fetch_category
    product_category = create_category unless product_category.present?
    product_category
  end

  protected

  def create_category
    ProductCategory.create(@category)
  end

  def fetch_category
    ProductCategory.find_by(name: @category[:name])
  end
end
