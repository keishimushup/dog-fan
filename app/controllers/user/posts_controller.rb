class User::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
  end

  def show
  end

  def edit
  end
  
  
  private
  
  def post_params
    #後で動画変更
    params.require(:post).permit(:image, :title, :explanation)
  end
end
