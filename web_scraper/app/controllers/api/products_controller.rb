class Api::ProductsController < ApiController
  def create
    return_value =  ScrapeService.new(params[:data]).call
    render json: return_value
  end

  def update
    params[:data][:id] = params[:id]
    product =  ScrapeService.new(params[:data]).call
    render json: { data: ActiveModelSerializers::SerializableResource
                           .new(product[:message], each_serializer: ProductSerializer) }
  end

  def categories
    product_categories = ProductCategory.all
    render json: { data: ActiveModelSerializers::SerializableResource
      .new(product_categories, each_serializer: ProductCategorySerializer) }
  end

  def index
    products = ProductService.new(params).call
    render json: { data: ActiveModelSerializers::SerializableResource
                          .new(products, each_serializer: ProductSerializer) }
  end

  def show
    product = Product.find_by(id: params[:id].to_i)
    render json: { data: ActiveModelSerializers::SerializableResource
                           .new(product, each_serializer: ProductSerializer) }
  end
end
