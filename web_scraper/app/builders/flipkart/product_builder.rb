# frozen_string_literal: true

module Flipkart::ProductBuilder
  def build_product
    {
      name: fetch_title,
      price: fetch_price.scan(/[0-9.]+/).join.to_f,
      description: fetch_description,
      product_image_url: fetch_product_image,
      properties: fetch_properties,
      provider: @provider,
      product_url: @url,
      rating: fetch_ratings
    }
  end

  def fetch_title
    @doc.at_css('h1').text.strip
  end

  def fetch_price
    @doc.at_css('div._30jeq3').text.strip
  end

  def fetch_description
    description = @doc.css('div._1mXcCf').at_css('p')&.text&.strip
    description = @doc.at_css('div._1mXcCf')&.text&.strip unless description.present?
    description
  end

  def fetch_product_image
    parent_div = @doc.css('div._3kidJX')
    image_url = nil
    parent_div.css('div').each do |child_div|
      img_src = child_div.at_css('img')
      if img_src.present?
        image_url = img_src['src']
        break
      end
    end
    image_url
  end

  def fetch_properties
    properties_element = @doc.css('div._22QfJJ')
    return_data = []
    properties_element.each do |div|
      key = div.at_css('span._1rcQuH').text.strip
      data = div.css('ul._1q8vHb').css('li a').map{|x| x.text.present? ? x.text.strip : nil}
      unless data.compact.present?
        data = div.css('ul._1q8vHb').css('li').css('div').css('div').map{|x| x.text.strip}
      end
      return_data.push({key: key.downcase.sub(' ', '_'), display: key, data: data.uniq.compact.reject { |c| c.empty? }})
    end
    puts return_data
    return_data
  end

  def fetch_ratings
    @doc.at_css('div._3LWZlK').text.strip.to_f
  end

  def fetch_categories
    @doc.css('a._2whKao').map { |z| z.text.strip }.drop(1).first
  end
end