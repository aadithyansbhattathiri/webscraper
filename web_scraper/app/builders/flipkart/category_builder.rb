# frozen_string_literal: true

module Flipkart::CategoryBuilder
  def build_category
    {
      name: fetch_categories,
      provider: @provider,
    }
  end
  def fetch_categories
    @doc.css('a._2whKao').map { |z| z.text.strip }.drop(1).first
  end
end