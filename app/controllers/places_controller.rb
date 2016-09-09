class PlacesController < ApplicationController
  def index
    @places = ['DaftCafe', 'Stixx', 'Casino Olympik']
  end
end
