# frozen_string_literal: true

class Flipkart::ScrapeParser < BaseScraperService
  include Flipkart::ProductBuilder
  include Flipkart::CategoryBuilder
  def initialize(params)
    super(params)
    @product_id = params[:id]
    @params = params
  end

  protected

  def parse
    category_data = build_category
    product_data = build_product
    data = { product: product_data, category: category_data, provider: @provider }
    if product_exists?
      product = ProductService.new(@params).update_product(data, @product_id)
      product
    else
      product = ProductService.new(@params).create_product(data)
      return 'success'
    end
  end

  def parse1
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
    @product_id.present? ? Product.find_by(id: @product_id) : Product.find_by(product_url: @url.strip)
  end
end