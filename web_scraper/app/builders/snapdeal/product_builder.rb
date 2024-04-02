# frozen_string_literal: true

module Snapdeal::ProductBuilder
  def build_product
    {
      name: fetch_title,
      price: fetch_price.to_f,
      description: fetch_description,
      product_image_url: fetch_product_image,
      properties: fetch_properties,
      provider: @provider,
      product_url: @url,
      rating: fetch_ratings
    }
  end

  def fetch_title
    @doc.at_css('h1.pdp-e-i-head').text.strip
  end

  def fetch_price
    @doc.css('span.pdp-final-price').search('span[itemprop="price"]').text.strip
  end

  def fetch_description
    @doc.at_css('div[itemprop="description"]')&.text&.strip
  end

  def fetch_product_image
    @doc.css('ul#bx-slider-left-image-panel').css('li').first.at_css('img')['src']
  end

  def fetch_properties
    properties_element = @doc.search('div.prod-attr-cont')
    return_data = []
    properties_element.search('div.prod-attr-tile').each do |div|
      key = div.search('div.product-attr-head').text.strip
      data = div.search('div.attr-val').map{|x| x.text.strip}
      return_data.push({key: key.downcase.sub(' ', '_'), display: key, data: data.uniq.compact.reject { |c| c.empty? }})
    end
    return_data
  end

  def fetch_ratings
    @doc.at_css('span[itemprop="ratingValue"]')&.text.strip.to_f
  end

  def fetch_categories
    @doc.css('a.bCrumbOmniTrack').map { |z| z.text.strip }.drop(1).first
  end
end