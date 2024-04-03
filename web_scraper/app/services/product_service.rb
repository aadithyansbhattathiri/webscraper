# frozen_string_literal: true

class ProductService
  def initialize(params)
    @category = params[:category] == "0" ? nil : params[:category]
    @search_keyword = params[:search]
  end

  def call
    if @search_keyword.present?
      Product.where("lower(name) like  '%#{@search_keyword.downcase}%'")
    elsif @category.present?
      Product.where(product_category_id: @category.to_i)
    else
      Product.all.order(created_at: :desc)
    end
  end

  def create_product(data)
    category = ProductCategoryService.new(data[:category], data[:provider]).call
    data[:product][:product_category_id] = category.id
    product = Product.create(data[:product])
    if product
      category.update(total_products: category.total_products + 1)
      return true
    else
      false
    end
  end

  def update_product(data, product_id)
    product = Product.find_by(id: product_id)
    product.update(data[:product])
    product
  end
end
