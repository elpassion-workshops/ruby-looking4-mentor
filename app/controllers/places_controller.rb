class PlacesController < ApplicationController
  API_KEY = 'AIzaSyAP1vwxyCM--MERNqLnncKfDUsx9YfqvTQ'

  def index
    @client = GooglePlaces::Client.new(API_KEY)
    @places = @client.spots(52.2321841, 20.984737, radius: 200)
  end
end
