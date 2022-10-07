class User::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @genres = Genre.all
    @posts = params[:name].present? ? Genre.find(params[:name]).posts.order(created_at: :desc) : Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to  posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to  posts_path
    else
      if @post.update(post_params)
      redirect_to post_path(@post.id)
      else
      render :edit
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to  posts_path
    else
      @post.destroy
      redirect_to posts_path
    end
  end


  private

  def post_params
    #後で動画に変更
    params.require(:post).permit(:image, :title, :explanation, :genre_id)
  end
end
