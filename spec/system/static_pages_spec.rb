require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "イマクリの文字列が存在することを確認" do
        expect(page).to have_content 'イマクリ'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end

      context "作品フィード", js: true do
        let!(:user) { create(:user) }
        let!(:production) { create(:production, user: user) }

        before do
          login_for_system(user)
        end

        it "作品のページネーションが表示されること" do
          login_for_system(user)
          create_list(:production, 6, user: user)
          visit root_path
          expect(page).to have_content "みんなの作品 (#{user.productions.count})"
          expect(page).to have_css "div.pagination"
          Production.take(5).each do |d|
            expect(page).to have_link d.name
          end
        end

        it "「新しい作品を作る」リンクが表示されること" do
         visit root_path
         expect(page).to have_link "新しい作品を作る", href: new_production_path
        end

        it "作品を削除後、削除成功のフラッシュが表示されること" do
          visit root_path
          click_on '削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content '作品が削除されました'
        end
      end
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "イマクリとは？の文字列が存在することを確認" do
      expect(page).to have_content 'イマクリとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('イマクリとは？')
    end
  end
end
