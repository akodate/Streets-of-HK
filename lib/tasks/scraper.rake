# namespace :list do
# desc "update the show database with the list"

#   task :update_shows => :environment do

#   Show.destroy_all

#   s = InputShowData.new
#   s.input_arrays

#   end

require 'json'

desc "Saves scraper data to database"
task :scrape_save => :environment do

  class StreetData
    include Mongoid::Document
    include Mongoid::Timestamps

    field :street_data, type: Array
  end

  data = StreetData.new(street_data: JSON.parse(File.open('lib/assets/Hong_Kong_Streets.json', 'r').read))
  data.save

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