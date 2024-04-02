# frozen_string_literal: true

class ScrapeService
  def initialize(params)
    @params = params
    @klass = params[:provider].freeze.constantize
  end

  def call
    start_scraping
  end

  protected

  def start_scraping
    return_data = @klass::ScrapeParser.new(@params).call
    return { message: return_data }
  end
end