class PlacesController < ApplicationController
  API_KEY = 'AIzaSyAP1vwxyCM--MERNqLnncKfDUsx9YfqvTQ'

  def index
    @query = if params[:query_id]
               Query.find(params[:query_id])
             elsif params[:query]
               Query.create(query_params)
             else
               Query.new
             end

    if @query.address.present?
      @coords = Geocoder.coordinates(@query.address)
      @client = GooglePlaces::Client.new(API_KEY)
      @places = @client.spots(@coords.first, @coords.last, radius: 200, keyword: @query.keyword)
    end
  end

  private

  def query_params
    params.require(:query).permit(:keyword, :address)
  end
end
