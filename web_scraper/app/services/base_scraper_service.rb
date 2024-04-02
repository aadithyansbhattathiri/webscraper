# frozen_string_literal: true

class BaseScraperService
  def initialize(params)
    @url = params[:url]
    @provider = params[:provider]
    @doc = nil
    @document = nil
  end

  def call
    invoke
    return 'page_not_found' unless @document.present?

    convert_to_html
    parse
  end

  protected

  def convert_to_html
    @doc = Nokogiri::HTML(@document)
  end

  def base_object
    Mechanize.new
  end

  def invoke
    agent = base_object
    begin
      page = agent.get(@url)
      @document = page.body if page.present? && page.body.present? && page.code.to_i == 200
    rescue => e
      nil
    end
  end
end