require "rails_helper"

RSpec.describe "作品編集", type: :request do
  let!(:user) { create(:user) }
  let!(:production) { create(:production, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get edit_production_path(production)
      expect(response).to render_template('productions/edit')
      patch production_path(production), params: { production: { name: "アンティークテーブル",
                                                                 description: "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。", # rubocop:disable Metrics/LineLength
                                                                 material: 1.5,
                                                                 tips: "SPF材と杉材を組み合わせることで、コントラストをつけました", # rubocop:disable Metrics/LineLength
                                                                 reference: "https://diy-recipe.com/recipe/3164/", # rubocop:disable Metrics/LineLength
                                                                 required_time: 1,
                                                                 popularity: 5 } }
      redirect_to production
      follow_redirect!
      expect(response).to render_template('productions/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      # 編集
      get edit_production_path(production)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      # 更新
      patch production_path(production), params: { production: { name: "アンティークテーブル",
                                                                 description: "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。", # rubocop:disable Metrics/LineLength
                                                                 material: 1.5,
                                                                 tips: "SPF材と杉材を組み合わせることで、コントラストをつけました", # rubocop:disable Metrics/LineLength
                                                                 reference: "https://diy-recipe.com/recipe/3164/", # rubocop:disable Metrics/LineLength
                                                                 required_time: 1,
                                                                 popularity: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
