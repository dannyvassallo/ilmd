class HomeController < ApplicationController
  def index
    @microposts = Micropost.all
    @query = Micropost.search do
      fulltext params[:search]
    end
    @microposts = @query.results
  end
end
