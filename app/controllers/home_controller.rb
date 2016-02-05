class HomeController < ApplicationController
  def index
    @movies = Movie.last(5)
  end
end
