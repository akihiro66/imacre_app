class ProductionsController < ApplicationController
  before_action :logged_in_user

  def new
    @production = Production.new
  end

  def show
    @production = Production.find(params[:id])
  end

  def create
    @production = current_user.productions.build(production_params)
    if @production.save
      flash[:success] = "作品が登録されました！"
      redirect_to production_path(@production)
    else
      render 'productions/new'
    end
  end

  def edit
    @production = Production.find(params[:id])
  end

  def update
    @production = Production.find(params[:id])
    if @production.update(production_params)
      flash[:success] = "作品情報が更新されました！"
      redirect_to @production
    else
      render 'edit'
    end
  end

  private

    def production_params
      params.require(:production).permit(:name, :description, :material, :tips,
                                         :reference, :required_time, :popularity, :memo)
    end
end
