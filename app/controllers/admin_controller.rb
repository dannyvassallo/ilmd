class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    # raise user_params.to_yaml

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to "/admin", notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:admin).tap do |p|
      p[:admin] = !!p[:admin]
    end
  end

  def authorize_admin
    redirect_to root_path unless admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

end
