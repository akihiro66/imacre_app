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
