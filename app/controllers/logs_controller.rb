class LogsController < ApplicationController
  before_action :logged_in_user

  def create
    @production = Production.find(params[:production_id])
    @log = @production.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "制作記録を追加しました！"
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
end
