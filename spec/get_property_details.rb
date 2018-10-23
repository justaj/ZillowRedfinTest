require_relative './zillow'
require 'faraday'
require 'active_support/core_ext/hash'


describe Zillow do
  describe "#get home information based off address" do
  context "using a full address" do
      @zillow = Zillow.new
      response = @zillow.get('property details')

  it "should return a success response" do
    expect(response.success?).to eql(true)
    expect(response.status).to eql(200)
  end

  it "should contain the given address" do
    parsed_response = Hash.from_xml(response.body)
    address = parsed_response['searchresults']['response']['results']['result']['address']
    @zillow = Zillow.new
    expect(address['street'].downcase).to eql(@zillow.address)
    expect(address['city'].downcase).to eql(@zillow.city)
    expect(address['state'].downcase).to eql(@zillow.state)
  end

    end
  end
end
