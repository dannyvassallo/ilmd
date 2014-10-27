class HomeController < ApplicationController
  def index
    @query = Micropost.search do
      fulltext params[:search]
      order_by :id, :desc
    end
    @microposts = @query.results
  end
end
