class User::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings.order(created_at: :desc)
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.order(created_at: :desc)
  end
end
