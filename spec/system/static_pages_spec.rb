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
