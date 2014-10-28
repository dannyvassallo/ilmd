class MemberController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]

  def make_admin
    @user = User.find_by_email(params[:emails][:email])
    unless @user.nil?
      @user.update_attribute(:admin, true)
    end
    redirect_to '/dashboard/develop'
  end

  def delete_admin
    @user = User.find_by_email(params[:emails][:email])
    unless @user.nil?
      @user.update_attribute(:admin, false)
    end
    redirect_to '/dashboard/develop'
  end

end
