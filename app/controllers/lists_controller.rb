class ListsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def create
    @production = Production.find(params[:production_id])
    @user = @production.user
    current_user.list(@production)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    list = List.find(params[:list_id])
    @production = list.production
    list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
