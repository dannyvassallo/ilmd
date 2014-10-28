class HomeController < ApplicationController
  def index
    @query = Micropost.search do
      fulltext params[:search]
      paginate :page => params[:page] || 1, :per_page => 10
      order_by :id, :desc
    end
    @microposts = @query.results
  end

end
