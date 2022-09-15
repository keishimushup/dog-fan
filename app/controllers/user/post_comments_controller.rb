class User::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    #コメントしているユーザーにログインしているユーザーを代入
    comment.user_id = current_user.id
    #コメントのpost_idカラムにpostのidを代入
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to post_path(params[:post_id])
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
