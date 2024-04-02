require 'open-uri'
require 'mechanize'

class NokoScraper
  def scrape
    agent = Mechanize.new
    #url = 'https://www.flipkart.com/kifara-women-kurti-pant-dupatta-set/p/itmf9c3b9999ac4b?pid=ETHGXMJXMHRBBF3B'
    # url = 'https://www.flipkart.com/hp-1008a-single-function-monochrome-laser-printer/p/itmfb6e7047e6ffc'
    # url = 'https://www.flipkart.com/elligator-wayfarer-sunglasses/p/itm6f485ce23ddbe?pid=SGLFMKNGNEN7SKUA&lid=LSTSGLFMKNGNEN7SKUAZFIJGU&marketplace=FLIPKART&fm=productRecommendation%2Fsimilar&iid=R%3As%3Bp%3ASGLFHQPHY2GZ4HFP%3Bl%3ALSTSGLFHQPHY2GZ4HFP0AZWKY%3Bpt%3App%3Buid%3Adc0b0263-edd5-11ee-8175-b7632ca6593f%3B.SGLFMKNGNEN7SKUA&ppt=pp&ppn=pp&ssid=n8hjjyxdio0000001711721277992&otracker=pp_reco_Similar%2BProducts_8_33.productCard.PMU_HORIZONTAL_Elligator%2BWayfarer%2BSunglasses_SGLFMKNGNEN7SKUA_productRecommendation%2Fsimilar_7&otracker1=pp_reco_PINNED_productRecommendation%2Fsimilar_Similar%2BProducts_GRID_productCard_cc_8_NA_view-all&cid=SGLFMKNGNEN7SKUA'
    url = 'https://www.flipkart.com/hp-deskjet-ink-advantage-4178-multi-function-wifi-color-inkjet-printer-voice-activated-printing-google-assistant-alexa-automatic-document-feeder-copy-scan-bluetooth-usb-simple-setup-smart-app-ideal-home/p/itmc2b563b07a893?pid=PRNFTXAWRRYNDWCF&lid=LSTPRNFTXAWRRYNDWCFBQ1AIT&marketplace=FLIPKART&store=6bo%2Ftia%2Fffn%2Ft64&srno=b_1_2&otracker=browse&otracker1=hp_rich_navigation_PINNED_neo%2Fmerchandising_NA_NAV_EXPANDABLE_navigationCard_cc_2_L2_view-all&fm=organic&iid=en_mK2oXeENFUb_sa2mjG88StjIQBR2pZ_Trzwj892iuCfu3ekuXtPebgrnMI9udpw76foYbDSG2cH9h5TTvXzxcg%3D%3D&ppt=browse&ppn=browse&ssid=pdmstgqhf40000001711782301897'
    puts 'Hello'
    page = agent.get(url)
    puts page.code
    doc = Nokogiri::HTML(page.body)
    title = doc.at_css('h1').text.strip
    price = doc.at_css('div._30jeq3').text.strip
    description = doc.at_css('li._21Ahn-')&.text&.strip
    categories = doc.css('a._2whKao').map { |z| z.text.strip }.drop(1).join('/')
    puts categories
    description = doc.at_css('div._1mXcCf')&.text&.strip
    puts "Description: #{description}"
    parent_div = doc.css('div._3kidJX')
    image_url = nil
    parent_div.css('div').each do |child_div|
      img_src = child_div.at_css('img')
      if img_src.present?
        image_url = img_src['src']
        break
      end
    end
    data = doc.css('ul._1q8vHb')
    data.each do |ul|
      puts(ul.css('li').pluck('id'))
    end

    te = doc.css('div._22QfJJ')
    return_data = []
    te.each do |div|

      key = div.at_css('span._1rcQuH').text.strip
      data = div.css('ul._1q8vHb').css('li a').map{|x| x.text.present? ? x.text.strip : nil}
      unless data.compact.present?
        data = div.css('ul._1q8vHb').css('li').css('div').css('div').map{|x| x.text.strip}
      end
      return_data.push({key: key, data: data.uniq.compact.reject { |c| c.empty? }})
    end

    puts "Return Data", return_data

    rating = doc.at_css('div._3LWZlK').text.strip
    { title: title, price: price, description: description, image_url: image_url, rating: rating,
      categories: categories }
  end

  def myntra_scrape
    #url = 'https://www.snapdeal.com/product/bentag-exerciser-single-spring-tummy/649577200211'
    url = 'https://www.snapdeal.com/product/bentag-exerciser-single-spring-tummy/649577200211'
    puts "YRL: #{url}"
    agent = Mechanize.new
    page = agent.get(url)
    doc = Nokogiri::HTML(page.body)
    #
    title = doc.at_css('h1.pdp-e-i-head').text.strip

    price = doc.at_css('span.pdp-final-price').text.strip

    image_url = doc.css('ul#bx-slider-left-image-panel').css('li').first.at_css('img')['src']


    return_data = []

    te = doc.search('div.prod-attr-cont')

    puts te.search('div.prod-attr-tile').count
    te.search('div.prod-attr-tile').each do |tile|

      puts tile.search('div.product-attr-head').text.strip
      puts tile.search('div.attr-val').map{|x| x.text.strip}
    end
    puts te.count

    puts return_data
    categories = doc.css('a.bCrumbOmniTrack').map { |z| z.text.strip }.drop(1).join('/')

    description = doc.at_css('div[itemprop="description"]')&.text&.strip

    ratings = doc.at_css('span[itemprop="ratingValue"]')&.text.strip
    data = { title: title, price: price, image_url: image_url, categories: categories, description: description, ratings: ratings }
    puts data
  end

  def amz_scrape

    url = 'https://www.amazon.in/ANNI-DESIGNER-Straight-Chinki-Green_L_Green_Large/dp/B0CPYJJJMM/?_encoding=UTF8&pd_rd_w=Dj62J&content-id=amzn1.sym.f1f8cdc6-a5d6-4268-8c12-1ccc947bb0d8&pf_rd_p=f1f8cdc6-a5d6-4268-8c12-1ccc947bb0d8&pf_rd_r=XKG8VNYW5DAD507T1435&pd_rd_wg=4ELJc&pd_rd_r=093736de-a533-4ebb-940c-71f68ca486a4&ref_=pd_gw_zg_women_reftag'
    #url = 'https://www.amazon.in/Luminous-Zelio-1100-Sinewave-Inverter/dp/B01994DUMW/?_encoding=UTF8&pd_rd_w=ff5uv&content-id=amzn1.sym.d2b04661-f8d7-498a-a11f-bdf02815bc31&pf_rd_p=d2b04661-f8d7-498a-a11f-bdf02815bc31&pf_rd_r=V1XVVDVJM9WJV4CM3H0A&pd_rd_wg=XxwAJ&pd_rd_r=50c4ca99-4636-479a-86d6-12b4b3af42d6&ref_=pd_gw_ls_gwc_pc_en1_&th=1'
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    price_symbol = doc.css('span.priceToPay').at_css('.a-price-symbol').text.strip
    price_amount = doc.at_css('.a-price-whole').text.strip
    price_decimal = doc.at_css('.a-price-decimal').text.strip
    price_fraction = doc.at_css('.a-price-fraction').text.strip
    puts price_symbol
    puts price_amount
    puts price_fraction
    price = price_symbol + price_amount + price_decimal + price_fraction

    # Extract product title
    title = doc.at_css('#productTitle').text.strip

    # Extract product price
    #price = doc.at_css('#priceblock_ourprice').text.strip

    # Extract product description (if available)
    #description = doc.at_css('#feature-bullets').text.strip
    #native_dropdown_selected_size_name
    img = doc.at_css('.imgTagWrapper img')['src']

    puts "Title: #{title}"
    puts "Price: #{price}"
    puts "Description: #{img}"
  end

end
