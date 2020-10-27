class LogsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :create

  def create
    @production = Production.find(params[:production_id])
    @log = @production.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "制作記録を追加しました！"
    # 製作予定リストページから製作記録が作成された場合、その作品をリストから削除
    List.find(params[:list_id]).destroy unless params[:list_id].nil?
    redirect_to production_path(@production)
  end

  def destroy
    @log = Log.find(params[:id])
    @production = @log.production
    if current_user == @production.user
      @log.destroy
      flash[:success] = "制作記録を削除しました"
    end
    redirect_to production_url(@production)
  end

  private

    def correct_user
      # 現在のユーザーが対象の作品を保有しているかどうか確認
      production = current_user.productions.find_by(id: params[:production_id])
      redirect_to root_url if production.nil?
    end
end