class StreetData

  include Mongoid::Document
  include Mongoid::Timestamps

  field :street_data, type: Array

  def self.look_up(term)
    result = []
    reg = Regexp.new("^" + term, true)
    StreetData.first.street_data.each do |obj|
      result << obj if reg.match(obj.keys[0])
      puts obj.keys[0]
      break if result.size >= 8
    end
    return result
  end

end