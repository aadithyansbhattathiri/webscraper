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
end
