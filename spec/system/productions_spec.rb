require 'rails_helper'

RSpec.describe "Productions", type: :system do
  let!(:user) { create(:user) }
  let!(:production) { create(:production, user: user) }

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

  describe "作品編集ページ" do
    before do
      login_for_system(user)
      visit production_path(production)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('作品情報の編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '作品名'
        expect(page).to have_content '説明'
        expect(page).to have_content '材料費 [円]'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content '作り方参照用URL'
        expect(page).to have_content '所要時間 [時間]'
        expect(page).to have_content '人気度 [1~5]'
      end
    end

    context "作品の更新処理" do
      it "有効な更新" do
        fill_in "作品名", with: "編集：アンティークテーブル"
        fill_in "説明", with: "編集：一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。"
        fill_in "材料費", with: 10000
        fill_in "コツ・ポイント", with: "編集：SPF材と杉材を組み合わせることで、コントラストをつけました"
        fill_in "作り方参照用URL", with: "https://diy-recipe.com/recipe/3164/5"
        fill_in "所要時間", with: 2
        fill_in "人気度", with: 3
        click_button "更新する"
        expect(page).to have_content "作品情報が更新されました！"
        expect(production.reload.name).to eq "編集：アンティークテーブル"
        expect(production.reload.description).to eq "編集：一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。"
        expect(production.reload.material).to eq 10000
        expect(production.reload.tips).to eq "編集：SPF材と杉材を組み合わせることで、コントラストをつけました"
        expect(production.reload.reference).to eq "https://diy-recipe.com/recipe/3164/5"
        expect(production.reload.required_time).to eq 2
        expect(production.reload.popularity).to eq 3
      end

      it "無効な更新" do
        fill_in "作品名", with: ""
        click_button "更新する"
        expect(page).to have_content '作品名を入力してください'
        expect(production.reload.name).not_to eq ""
      end
    end

    context "作品の削除処理", js: true do
      it "削除成功のフラッシュが表示されること" do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '作品が削除されました'
      end
    end
  end

  describe "作品詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit production_path(production)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{production.name}")
      end

      it "作品情報が表示されること" do
        expect(page).to have_content production.name
        expect(page).to have_content production.description
        expect(page).to have_content production.material
        expect(page).to have_content production.tips
        expect(page).to have_content production.reference
        expect(page).to have_content production.required_time
        expect(page).to have_content production.popularity
      end
    end

    context "作品の削除", js: true do
      it "削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit production_path(production)
        within find('.change-production') do
          click_on '削除'
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '作品が削除されました'
      end
    end
  end
end
