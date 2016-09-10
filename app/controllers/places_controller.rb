class PlacesController < ApplicationController
  API_KEY = 'AIzaSyAP1vwxyCM--MERNqLnncKfDUsx9YfqvTQ'

  def index
    @query = if params[:query_id]
               Query.find(params[:query_id])
             elsif params[:query]
               Query.find_or_create_by(query_params)
             else
               Query.new
             end

    if @query.valid?
      @coords = Geocoder.coordinates(@query.address)
      @client = GooglePlaces::Client.new(API_KEY)
      @places = @client.spots(@coords.first, @coords.last, radius: 200, keyword: @query.keyword)

      @query.increment(:searches_count)
      @query.searched_at = Time.current
      @query.save
    end
  end

  private

  def query_params
    params.require(:query).permit(:keyword, :address)
  end
end
