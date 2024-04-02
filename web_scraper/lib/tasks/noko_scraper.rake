namespace :noko_scraper do
  task scrape: :environment do
    NokoScraper.new.myntra_scrape
  end
end
