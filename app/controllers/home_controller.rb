class HomeController < ApplicationController
  before_filter :authorize, :except => :index
  
  def index
    if params[:search]
      @microposts = Micropost.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    else
      @microposts = Micropost.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 30)
    end
  end

  def status
    render html: '<b>html goes here<b/>'.html_safe
  end


end
