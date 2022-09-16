class User::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
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
    @genres = Genre.all
    @posts = params[:name].present? ? Genre.find(params[:name]).posts : Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    #後で動画に変更
    params.require(:post).permit(:image, :title, :explanation, :genre_id)
  end
end
