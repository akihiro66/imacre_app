class ProductionsController < ApplicationController
  before_action :logged_in_user

  def new
    @production = Production.new
  end
end
