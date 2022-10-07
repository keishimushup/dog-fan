class User::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to  posts_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to  posts_path
    else
      if @user.update(user_params)
        redirect_to user_path(@user.id)
      else
        render :edit
      end
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email)
  end
end
