class Zillow
  attr_accessor :token, :url
  attr_reader :address, :city, :state

  def initialize
    require 'yaml'
    zillow_yml = YAML::load(File.open('zillow_helper.yml'))
    @token = zillow_yml['zillow']['token']
    @address = zillow_yml['zillow']['address'].downcase
    @city = zillow_yml['zillow']['city'].downcase
    @state = zillow_yml['zillow']['state'].downcase

  end

  def get_url(type)
    case type
    when 'property details'
    url = "http://www.zillow.com/webservice/GetDeepSearchResults.htm" + "?zws-id=" + @token + "&address=" + @address + "&citystatezip=" + @city + " " + @state
    end
    return url
  end


  def get(type)
    require 'active_support/core_ext/hash'
    url = get_url(type)
    conn = Faraday.new(:url => url)
    response = conn.get
    raise "Test failed.  API response was #{response.status}" if response.status != 200
    return response
  end

end
