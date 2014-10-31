class HomeController < ApplicationController
  before_filter :authorize, :except => :index
  
  def index
    if params[:search]
      @microposts = Micropost.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    else
      @microposts = Micropost.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    end
  end
  
end
