# frozen_string_literal: true

module Snapdeal::CategoryBuilder
  def build_category
    {
      name: fetch_categories,
      provider: @provider
    }
  end
  def fetch_categories
    @doc.css('a.bCrumbOmniTrack').map { |z| z.text.strip }.drop(1).first
  end
end