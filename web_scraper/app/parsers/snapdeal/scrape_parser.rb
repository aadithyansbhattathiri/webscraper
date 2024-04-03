# frozen_string_literal: true

class Snapdeal::ScrapeParser < BaseScraperService
  include Snapdeal::ProductBuilder
  include Snapdeal::CategoryBuilder
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
    #product = product_exists? ? ProductService.new(@params).update_product(data, @product_id) : ProductService.new(@params).create_product(data)
    if product_exists?
      product = ProductService.new(@params).update_product(data, @product_id)
      product
    else
      product = ProductService.new(@params).create_product(data)
      return 'success'
    end
  end
  def product_exists?
    @product_id.present? ? Product.find_by(id: @product_id) : Product.find_by(product_url: @url.strip)
  end
end