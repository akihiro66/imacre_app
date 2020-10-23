require 'rails_helper'

RSpec.describe "作品登録", type: :request do
  let!(:user) { create(:user) }
  let!(:production) { create(:production, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test_production.jpg') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }

  context "ログインしているユーザーの場合" do
    before do
      get new_production_path
      login_for_request(user)
    end

    context "フレンドリーフォワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_production_path
      end
    end

    it "有効な作品データで登録できること" do
      expect {
        post productions_path, params: { production: { name: "アンティークテーブル",
                                                       description: "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。", # rubocop:disable Metrics/LineLength
                                                       material: 1.5,
                                                       tips: "SPF材と杉材を組み合わせることで、コントラストをつけました",
                                                       reference: "https://diy-recipe.com/recipe/3164/", # rubocop:disable Metrics/LineLength
                                                       required_time: 1,
                                                       popularity: 5,
                                                       picture: picture } }
      }.to change(Production, :count).by(1)
      follow_redirect!
      expect(response).to render_template('productions/show')
    end

    it "無効な作品データでは登録できないこと" do
      expect {
        post productions_path, params: { production: { name: "",
                                                       description: "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。", # rubocop:disable Metrics/LineLength
                                                       material: 1.5,
                                                       tips: "SPF材と杉材を組み合わせることで、コントラストをつけました",
                                                       reference: "https://diy-recipe.com/recipe/3164/", # rubocop:disable Metrics/LineLength
                                                       required_time: 1,
                                                       popularity: 5,
                                                       picture: picture } }
      }.not_to change(Production, :count)
      expect(response).to render_template('productions/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_production_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
