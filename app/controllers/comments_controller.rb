class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @production = Production.find(params[:production_id])
    @user = @production.user
    @comment = @production.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@production.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
  end
end
