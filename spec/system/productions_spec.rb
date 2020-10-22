require 'rails_helper'

RSpec.describe "Productions", type: :system do
  let!(:user) { create(:user) }

  describe "作品登録ページ" do
    before do
      login_for_system(user)
      visit new_production_path
    end

    context "ページレイアウト" do
      it "「作品登録」の文字列が存在すること" do
        expect(page).to have_content '作品登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('作品登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '作品名'
        expect(page).to have_content '説明'
        expect(page).to have_content '材料費 [円]'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content '作り方参照用URL'
        expect(page).to have_content '所要時間 [時間]'
        expect(page).to have_content '人気度 [1~5]'
        expect(page).to have_content 'メモ'
      end
    end

    context "作品登録処理" do
      it "有効な情報で作品登録を行うと作品登録成功のフラッシュが表示されること" do
        fill_in "作品名", with: "アンティークテーブル"
        fill_in "説明", with: "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。"
        fill_in "材料費", with: 1.5
        fill_in "コツ・ポイント", with: "SPF材と杉材を組み合わせることで、コントラストをつけました"
        fill_in "作り方参照用URL", with: "https://diy-recipe.com/recipe/3164/"
        fill_in "所要時間", with: 1
        fill_in "人気度", with: 5
        click_button "登録する"
        expect(page).to have_content "作品が登録されました！"
      end

      it "無効な情報で料理登録を行うと料理登録失敗のフラッシュが表示されること" do
        fill_in "作品名", with: ""
        fill_in "説明", with: "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。"
        fill_in "材料費", with: 1.5
        fill_in "コツ・ポイント", with: "SPF材と杉材を組み合わせることで、コントラストをつけました"
        fill_in "作り方参照用URL", with: "https://diy-recipe.com/recipe/3164/"
        fill_in "所要時間", with: 1
        fill_in "人気度", with: 5
        click_button "登録する"
        expect(page).to have_content "作品名を入力してください"
      end
    end
  end
end
