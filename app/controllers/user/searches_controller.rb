class User::SearchesController < ApplicationController
  def search
    #キーワード検索
    @range = params[:range]
    #ユーザーの名前から検索
    if @range == "User"
      @user = User.where("name LIKE ?", "%#{params[:word]}%")
    #投稿のタイトルから検索
    else
      @post = Post.where("title LIKE ?", "%#{params[:word]}%")
    end
  end
end
