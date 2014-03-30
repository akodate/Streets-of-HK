namespace :scraper do

  require 'open-uri'
  require 'json'

  DATA_DIR = "lib/assets"
  Dir.mkdir(DATA_DIR) unless File.exists?(DATA_DIR)

  BASE_WIKIPEDIA_URL = "http://en.wikipedia.org"
  TARGET_URL = "#{BASE_WIKIPEDIA_URL}/wiki/List_of_streets_and_roads_in_Hong_Kong"

  HEADERS_HASH = {"User-Agent" => "Ruby/#{RUBY_VERSION}"}
  WIKI_URL_REGEX = /\/wiki\//
  CHINESE_REGEX = /[[:^ascii:]]+(?=\)|<\/span>)/

  target_page = Nokogiri::HTML(open(TARGET_URL))
  local_fname = "#{DATA_DIR}/#{File.basename('Hong_Kong_Streets')}.json"
  lists = target_page.css('div#content div#bodyContent div#mw-content-text table.multicol tr td')
  chinese_roads = []

  class StreetData
    include Mongoid::Document
    include Mongoid::Timestamps

    field :street_data, type: Array
  end


  desc "Runs scraper and saves results to file"
  task :run => :environment do

    lists.each do |list|
      puts list.css('h3').text
      puts list.css('dl').text

      # count = -1
      list.css('ul li a').each do |a|
        # count += 1
        if a['href'] =~ WIKI_URL_REGEX # && count % 12 == 0
          # puts count

          remote_url = BASE_WIKIPEDIA_URL + a['href']
          puts "Fetching #{remote_url}"
          begin
            scrape_page = open(remote_url, HEADERS_HASH).read
          rescue Exception=>e
            puts "Error: #{e}"
            sleep 5
          else
            chinese_road = CHINESE_REGEX.match(scrape_page)
            puts("'" + a.text + "' is '" + chinese_road.to_s + "'")
            chinese_roads.push({ a.text => chinese_road.to_s }) if chinese_road
          ensure
            sleep 1.0 + rand
          end
        end
      end
    end

    File.open(local_fname, 'w'){|file| file.write(chinese_roads.to_json)}
    puts "\t...Success, saved to #{local_fname}"

  end


  desc "Saves scraper file data to database"
  task :save => :environment do

    data = StreetData.new(street_data: JSON.parse(File.open('lib/assets/Hong_Kong_Streets.json', 'r').read))
    if data.save
      puts "\t...Success, saved to database"
    end

  end


end

# namespace :mongo do

#   include Mongoid::Document

#   desc "lists collections"
#   task :list => ['mongo:db'] do
#     @db.collection_names.each { |name| puts name }
#   end

#   desc "gets database"
#   task :db => :environment do
#     @db = Mongoid.database
#   end

# end