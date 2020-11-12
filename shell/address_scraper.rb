require 'csv'
require 'nokogiri'
require 'open-uri'
require 'json'

class AddressScraper
  def scrape
    write_file = 'all_addresses.csv'
    50.times do |i|
      file = "address#{i+1}.html"
      doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
      doc.search('.content .list-unstyled .col-sm-6 p:first-child').each do |element|
        CSV.open(write_file, 'a') do |csv|
          csv << [element.text.strip[9..-1]]
        end
      end
    end
  end

  def validate
    read_file = 'all_addresses.csv'
    write_file = 'valid_addresses.csv'

    # only keep addresses that return a lat/long in nominatim
    CSV.foreach(read_file) do |row|
      next if row[0].nil?
      row[0].strip!
      query_url = "https://nominatim.openstreetmap.org/search?q=#{row[0]} Singapore&format=json"
      data = JSON.parse(open(query_url).read)
      next if data[0].nil?
      if (data[0]["lat"] && data[0]["lon"])
        CSV.open(write_file, 'a') do |csv|
          csv << ["#{row[0]} Singapore"]
        end
      end
      sleep(1)
    end
  end

  def format
    puts "formatting addresses..."
    write_file = 'valid_addresses.csv'
    addresses = []
    CSV.foreach(write_file) do |row|
      addresses << "#{row[0]},"
    end
    CSV.open(write_file, 'wb', force_quotes: true) do |csv|
      addresses.each do |address|
        csv << [address]
      end
    end
    puts "formatted addresses!"
  end
end

scraper = AddressScraper.new
# scraper.scrape
# scraper.validate
scraper.format
