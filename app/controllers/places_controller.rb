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
      @query.searched!

      @client = GooglePlaces::Client.new(API_KEY)
      @places = @client.spots(@query.latitude, @query.longitude, radius: 200, keyword: @query.keyword)
    end
  end

  private

  def query_params
    params.require(:query).permit(:keyword, :address)
  end
end
