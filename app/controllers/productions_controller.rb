class ProductionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def new
    @production = Production.new
    @production.materials.build
  end

  def index
    @log = Log.new

    # CSV出力時のファイル名指定
    respond_to do |format|
      format.html
      format.csv {
        send_data render_to_string,
                  filename: "みんなの作品一覧_#{Time.current.strftime('%Y%m%d_%H%M')}.csv"
      }
    end
  end

  def show
    @production = Production.find(params[:id])
    @comment = Comment.new
    @log = Log.new
  end

  def create
    @production = current_user.productions.build(production_params)
    if @production.save
      flash[:success] = "作品が登録されました！"
      Log.create(production_id: @production.id, content: @production.memo)
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

  def destroy
    @production = Production.find(params[:id])
    if current_user.admin? || current_user?(@production.user)
      @production.destroy
      flash[:danger] = "作品が削除されました"
      redirect_to request.referrer == user_url(@production.user) ? user_url(@production.user) : root_url # rubocop:disable Metrics/LineLength
    else
      flash[:danger] = "他人の作品は削除できません"
      redirect_to root_url
    end
  end

  private

    def production_params
      params.require(:production).permit(:name, :description, :material, :tips,
                                         :reference, :required_time, :popularity, :memo, :picture,
                                         materials_attributes: [:id, :name, :amount])
    end

    def correct_user
      # 現在のユーザーが更新対象の作品を保有しているかどうか確認
      @production = current_user.productions.find_by(id: params[:id])
      redirect_to root_url if @production.nil?
    end
end
