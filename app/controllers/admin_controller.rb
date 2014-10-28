class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit
  end

  def update
  end

  def authorize_admin
    redirect_to root_path unless admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

end
