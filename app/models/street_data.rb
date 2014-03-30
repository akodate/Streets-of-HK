class StreetData
  include Mongoid::Document
  include Mongoid::Timestamps

  def self.look_up(term)
    StreetData.find_by()
  end

end