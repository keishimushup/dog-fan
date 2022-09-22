class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def confilm
    @user = User.find(params[:id])
  end

  def destroy
    @user = current_admin
    if @user.email == 'guest@example.com'
      flash[:notice] = "ゲストログインユーザーでは削除できません"
      redirect_to admin_root_path
    else
      user = User.find(params[:id])
      user.destroy
      redirect_to admin_root_path
    end
  end
end
