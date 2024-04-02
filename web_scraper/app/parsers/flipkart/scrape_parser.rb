# frozen_string_literal: true

class Flipkart::ScrapeParser < BaseScraperService
  include Flipkart::ProductBuilder
  include Flipkart::CategoryBuilder
  def initialize(params)
    super(params)
  end

  protected
  def parse
    return 'already_exists' if product_exists?

    category_data = build_category
    category = ProductCategoryService.new(category_data, @provider).call
    product_data = build_product
    product_data[:product_category_id] = category.id
    product = Product.create(product_data)
    category.update(total_products: category.total_products + 1) if product
    if product
      category.update(total_products: category.products.count + 1)
      return 'success'
    end
  end
  def product_exists?
    Product.find_by(product_url: @url.strip)
  end
end