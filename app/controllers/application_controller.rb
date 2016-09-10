class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_popular_queries

  private

  def set_popular_queries
    @popular_queries = Query.order(searches_count: :desc, searched_at: :desc).limit(5)
  end

end
