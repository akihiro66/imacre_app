class FavoritesController < ApplicationController
  before_action :logged_in_user

  def index
    @favorites = current_user.favorites
  end

  def create
    @production = Production.find(params[:production_id])
    @user = @production.user
    current_user.favorite(@production)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @production = Production.find(params[:production_id])
    current_user.favorites.find_by(production_id: @production.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
