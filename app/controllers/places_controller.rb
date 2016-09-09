class PlacesController < ApplicationController
  API_KEY = 'AIzaSyAP1vwxyCM--MERNqLnncKfDUsx9YfqvTQ'

  def index
    if params[:where].present?
      @coords = Geocoder.coordinates(params[:where])
      @client = GooglePlaces::Client.new(API_KEY)
      @places = @client.spots(@coords.first, @coords.last, radius: 200, keyword: params[:what])
    end
  end
end
