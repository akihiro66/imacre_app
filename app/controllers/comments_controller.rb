class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @production = Production.find(params[:production_id])
    @user = @production.user
    @comment = @production.comments.build(user_id: current_user.id,
                                          content: params[:comment][:content])
    if !@production.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @production = @comment.production
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to production_url(@production)
  end
end
