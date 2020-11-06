require 'rails_helper'

RSpec.describe "Productions", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:production) { create(:production, :picture, :materials, user: user) }
  let!(:comment) { create(:comment, user_id: user.id, production: production) }
  let!(:log) { create(:log, production: production) }

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
        expect(page).to have_css 'label[for=production_materials_attributes_0_name]', text: '材料（10種類まで登録可）', count: 1 # rubocop:disable Metrics/LineLength
        expect(page).to have_css 'label[for=production_materials_attributes_0_amount]', text: '数量', count: 1 # rubocop:disable Metrics/LineLength
        expect(page).to have_content '材料費 [円]'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content '作り方参照用URL'
        expect(page).to have_content '所要時間 [時間]'
        expect(page).to have_content '人気度 [1~5]'
        expect(page).to have_content 'メモ'
      end

      it "材料入力部分が10行表示されること" do
        expect(page).to have_css 'input.material_name', count: 10
        expect(page).to have_css 'input.material_amount', count: 10
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
        attach_file "production[picture]", "#{Rails.root}/spec/fixtures/test_production.jpg"
        click_button "登録する"
        expect(page).to have_content "作品が登録されました！"
      end

      it "画像無しで登録すると、デフォルト画像が割り当てられること" do
        fill_in "作品名", with: "アンティークテーブル"
        click_button "登録する"
        expect(page).to have_link(href: production_path(Production.first))
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
        expect(page).to have_css 'p.title-material-name', text: '材料（10種類まで登録可）', count: 1
        expect(page).to have_css 'p.title-material-amount', text: '数量', count: 1
        expect(page).to have_content '材料費 [円]'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content '作り方参照用URL'
        expect(page).to have_content '所要時間 [時間]'
        expect(page).to have_content '人気度 [1~5]'
      end

      it "材料入力部分が10行表示されること" do
        expect(page).to have_css 'input.material_name', count: 10
        expect(page).to have_css 'input.material_amount', count: 10
      end
    end

    context "作品の更新処理" do
      it "有効な更新" do
        fill_in "作品名", with: "編集：アンティークテーブル"
        fill_in "説明", with: "編集：一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。"
        fill_in "production[materials_attributes][0][name]", with: "編集-SPF材"
        fill_in "production[materials_attributes][0][amount]", with: "編集-2本"
        fill_in "材料費", with: 10000
        fill_in "コツ・ポイント", with: "編集：SPF材と杉材を組み合わせることで、コントラストをつけました"
        fill_in "作り方参照用URL", with: "https://diy-recipe.com/recipe/3164/5"
        fill_in "所要時間", with: 2
        fill_in "人気度", with: 3
        attach_file "production[picture]", "#{Rails.root}/spec/fixtures/test_production2.jpg"
        click_button "更新する"
        expect(page).to have_content "作品情報が更新されました！"
        expect(production.reload.name).to eq "編集：アンティークテーブル"
        expect(production.reload.description).to eq "編集：一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。"
        expect(production.reload.materials.first.name).to eq "編集-SPF材"
        expect(production.reload.materials.first.amount).to eq "編集-2本"
        expect(production.reload.material).to eq 10000
        expect(production.reload.tips).to eq "編集：SPF材と杉材を組み合わせることで、コントラストをつけました"
        expect(production.reload.reference).to eq "https://diy-recipe.com/recipe/3164/5"
        expect(production.reload.required_time).to eq 2
        expect(production.reload.popularity).to eq 3
        expect(production.reload.picture.url).to include "test_production2.jpg"
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
        production.materials.each do |i|
          expect(page).to have_content i.name
          expect(page).to have_content i.amount
        end
        expect(page).to have_link nil, href: production_path(production), class: 'production-picture' # rubocop:disable Metrics/LineLength
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

    context "コメントの登録＆削除" do
      it "自分の作品に対するコメントの登録＆削除が正常に完了すること" do
        login_for_system(user)
        visit production_path(production)
        fill_in "comment_content", with: "意外に簡単に出来ますよ！"
        click_button "コメント"
        within find("#comment-#{Comment.last.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: '意外に簡単に出来ますよ！'
        end
        expect(page).to have_content "コメントを追加しました！"
        click_link "削除", href: comment_path(Comment.last)
        expect(page).not_to have_selector 'span', text: '意外に簡単に出来ますよ！'
        expect(page).to have_content "コメントを削除しました"
      end

      it "別ユーザーの作品のコメントには削除リンクが無いこと" do
        login_for_system(other_user)
        visit production_path(production)
        within find("#comment-#{comment.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: comment.content
          expect(page).not_to have_link '削除', href: production_path(production)
        end
      end
    end

    context "製作記録の登録＆削除" do
      context "作品詳細ページから" do
        it "自分の作品に対する製作記録の登録＆削除が正常に完了すること" do
          login_for_system(user)
          visit production_path(production)
          fill_in "log_content", with: "製作記録投稿テスト"
          click_button "製作記録の追加"
          within find("#log-#{Log.first.id}") do
            expect(page).to have_selector 'span', text: "#{production.logs.count}回目"
            expect(page).to have_selector 'span',
                                          text: %Q(#{Log.last.created_at.strftime("%Y/%m/%d(%a)")})
            expect(page).to have_selector 'span', text: '製作記録投稿テスト'
          end
          expect(page).to have_content "製作記録を追加しました！"
          click_link "削除", href: log_path(Log.first)
          expect(page).not_to have_selector 'span', text: '製作記録投稿テスト'
          expect(page).to have_content "製作記録を削除しました"
        end

        it "別ユーザーの作品ログには製作記録の登録フォームが無いこと" do
          login_for_system(other_user)
          visit production_path(production)
          expect(page).not_to have_button "作る"
        end
      end

      context "トップページから" do
        it "自分の作品に対する製作記録の登録が正常に完了すること" do
          login_for_system(user)
          visit root_path
          fill_in "log_content", with: "製作記録投稿テスト"
          click_button "追加"
          expect(Log.first.content).to eq '製作記録投稿テスト'
          expect(page).to have_content "製作記録を追加しました！"
        end

        it "別ユーザーの作品には製作記録の登録フォームがないこと" do
          create(:production, user: other_user)
          login_for_system(user)
          user.follow(other_user)
          visit root_path
          within find("#production-#{Production.first.id}") do
            expect(page).not_to have_button "作る"
          end
        end
      end

      context "プロフィールページから" do
        it "自分の作品に対する製作記録の登録が正常に完了すること" do
          login_for_system(user)
          visit user_path(user)
          fill_in "log_content", with: "製作記録投稿テスト"
          click_button "追加"
          expect(Log.first.content).to eq '製作記録投稿テスト'
          expect(page).to have_content "製作記録を追加しました！"
        end
      end

      context "製作予定リストページから" do
        it "自分の作品に対する製作記録の登録が正常に完了し、リストから作品が削除されること" do
          login_for_system(user)
          user.list(production)
          visit lists_path
          expect(page).to have_content production.name
          fill_in "log_content", with: "製作記録投稿テスト"
          click_button "追加"
          expect(Log.first.content).to eq '製作記録投稿テスト'
          expect(page).to have_content "製作記録を追加しました！"
          expect(List.count).to eq 0
        end
      end
    end
  end

  context "検索機能" do
    context "ログインしている場合" do
      before do
        login_for_system(user)
        visit root_path
      end

      it "ログイン後の各ページに検索窓が表示されていること" do
        expect(page).to have_css 'form#production_search'
        visit about_path
        expect(page).to have_css 'form#production_search'
        visit users_path
        expect(page).to have_css 'form#production_search'
        visit user_path(user)
        expect(page).to have_css 'form#production_search'
        visit edit_user_path(user)
        expect(page).to have_css 'form#production_search'
        visit following_user_path(user)
        expect(page).to have_css 'form#production_search'
        visit followers_user_path(user)
        expect(page).to have_css 'form#production_search'
        visit productions_path
        expect(page).to have_css 'form#production_search'
        visit production_path(production)
        expect(page).to have_css 'form#production_search'
        visit new_production_path
        expect(page).to have_css 'form#production_search'
        visit edit_production_path(production)
        expect(page).to have_css 'form#production_search'
      end

      it "フィードの中から検索ワードに該当する結果が表示されること" do
        create(:production, name: 'サイドテーブル', user: user)
        create(:production, name: 'ローテーブル', user: other_user)
        create(:production, name: '本棚', user: user)
        create(:production, name: '飾り棚', user: other_user)

        # 誰もフォローしない場合
        fill_in 'q_name_cont', with: 'テーブル'
        click_button '検索'
        expect(page).to have_css 'h3', text: "”テーブル”の検索結果：1件"
        within find('.productions') do
          expect(page).to have_css 'li', count: 1
        end
        fill_in 'q_name_cont', with: '棚'
        click_button '検索'
        expect(page).to have_css 'h3', text: "”棚”の検索結果：1件"
        within find('.productions') do
          expect(page).to have_css 'li', count: 1
        end

        # other_userをフォローする場合
        user.follow(other_user)
        fill_in 'q_name_cont', with: 'テーブル'
        click_button '検索'
        expect(page).to have_css 'h3', text: "”テーブル”の検索結果：2件"
        within find('.productions') do
          expect(page).to have_css 'li', count: 2
        end
        fill_in 'q_name_cont', with: '棚'
        click_button '検索'
        expect(page).to have_css 'h3', text: "”棚”の検索結果：2件"
        within find('.productions') do
          expect(page).to have_css 'li', count: 2
        end
      end

      it "検索ワードを入れずに検索ボタンを押した場合、作品一覧が表示されること" do
        fill_in 'q_name_cont', with: ''
        click_button '検索'
        expect(page).to have_css 'h3', text: "作品一覧"
        within find('.productions') do
          expect(page).to have_css 'li', count: Production.count
        end
      end
    end

    context "ログインしていない場合" do
      it "検索窓が表示されないこと" do
        visit root_path
        expect(page).not_to have_css 'form#production_search'
      end
    end
  end
end
