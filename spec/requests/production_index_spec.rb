require "rails_helper"

RSpec.describe "料理一覧ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:production) { create(:production, user: user) }

  context "ログインしているユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get productions_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('productions/index')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get productions_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
