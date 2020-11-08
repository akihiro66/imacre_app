# ユーザー
User.create!(
  [
    {
      name:  "松本 一郎",
      email: "matsumoto@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name:  "佐々木 二郎",
      email: "sasaki@example.com",
      password:              "password",
      password_confirmation: "password",
    },
    {
      name:  "採用 太郎",
      email: "recruit@example.com",
      password:              "password",
      password_confirmation: "password",
    },
  ]
)

# フォロー関係
user1 = User.find(1)
user2 = User.find(2)
user3 = User.find(3)
user3.follow(user1)
user3.follow(user2)

## 3ユーザー、それぞれ5作品ずつ作成
Production.create!(
  [
    {
      name: "木目調の壁紙に張り替え",
      user_id: 1,
      description: "既存の壁紙をはがし、木目調の壁紙に張り替えました！",
      material: 5000,
      tips: "のり付きの壁紙を選んだ方がいい",
      reference: "https://kabegamiyahonpo.com/",
      required_time: 5,
      popularity: 5,
      memo: "結構簡単だった",
      picture: open("#{Rails.root}/public/images/production1.jpg"),
      materials_attributes: [
                                { name: "木目調壁紙", amount: "10m" },
                                { name: "張り替え工具", amount: "1セット" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "テレビボード",
      user_id: 2,
      description: "ツーバイ材とアングル金物で作りました！",
      material: 8000,
      tips: "材料はホームセンターでカットしてもらう方がラク！",
      reference: "https://oenblog.com/diy/diy-tv-racks/",
      required_time: 2,
      popularity: 5,
      memo: "ちょっと大きすぎたかな",
      picture: open("#{Rails.root}/public/images/production2.jpg"),
      materials_attributes: [
                                { name: "２✖️４材(450mm)", amount: "26本" },
                                { name: "アングル金物(450mm)", amount: "8本" },
                                { name: "アングル金物(1800mm)", amount: "4本" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "鉄筋棒でインダストリアルなカーテンレール",
      user_id: 3,
      description: "鉄筋棒を金物で固定するだけ！",
      material: 1500,
      tips: "下地が入っているか確認が必要！",
      reference: "https://roomclip.jp/mag/archives/7033",
      required_time: 1,
      popularity: 4,
      memo: "窓幅プラス200mmの鉄筋が必要",
      picture: open("#{Rails.root}/public/images/production3.jpg"),
      materials_attributes: [
                                { name: "鉄筋棒(1800mm)", amount: "2本" },
                                { name: "固定金物", amount: "5個" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "レンガ調の壁紙に張り替え",
      user_id: 1,
      description: "既存の壁紙をはがし、木目調の壁紙に張り替えました！",
      material: 5000,
      tips: "のり付きの壁紙を選んだ方がいい",
      reference: "https://kabegamiyahonpo.com/",
      required_time: 5,
      popularity: 5,
      memo: "レンガの柄を合わせるのが大変",
      picture: open("#{Rails.root}/public/images/production4.jpg"),
      materials_attributes: [
                                { name: "レンガ調壁紙", amount: "10m" },
                                { name: "張り替え工具", amount: "1セット" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "ショップ風の壁面収納",
      user_id: 2,
      description: "2×4材とディアウォールを使った壁面収納",
      material: 10000,
      tips: "金物をつけるときは高さをしっかり合わせる",
      reference: "https://limia.jp/idea/65076/",
      required_time: 5,
      popularity: 3,
      memo: "ベニヤは付けなくてもよかった",
      picture: open("#{Rails.root}/public/images/production5.jpg"),
      materials_attributes: [
                                { name: "２✖️４材(2400mm)", amount: "3本" },
                                { name: "ベニヤ板", amount: "4枚" },
                                { name: "金物類", amount: "適量" },
                                { name: "ビス", amount: "適量" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "レザーパスケース",
      user_id: 3,
      description: "型紙に合わせてレザーを切り出し、手縫いで作成！",
      material: 500,
      tips: "縫う穴を開けるときは上から真っ直ぐ叩く",
      reference: "https://www.leathercraft.jp/kits/stationery/pass-case-kit/list/",
      required_time: 3,
      popularity: 5,
      memo: "手縫いは結構大変",
      picture: open("#{Rails.root}/public/images/production6.jpg"),
      materials_attributes: [
                                { name: "レザー", amount: "適量" },
                                { name: "レザークラフト道具", amount: "適量" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "衣装ケースをお洒落にリメイク",
      user_id: 1,
      description: "ステンシルシートの上からスプレーするだけ！",
      material: 500,
      tips: "しっかりと養生した方がいい",
      reference: "https://funq.jp/lightning/article/477648/",
      required_time: 1,
      popularity: 5,
      memo: "スプレーは少しずつやる",
      picture: open("#{Rails.root}/public/images/production7.jpg"),
      materials_attributes: [
                                { name: "好きな色のスプレー", amount: "1本" },
                                { name: "ステンシルシート", amount: "1セット" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "スタッズ付きレザーパスケース",
      user_id: 2,
      description: "型紙に合わせてレザーを切り出し、好きなデザインのスタッズを付け手縫いで作成！",
      material: 1000,
      tips: "穴を開けるときは上から真っ直ぐ叩く",
      reference: "https://www.leathercraft.jp/kits/stationery/pass-case-kit/list/",
      required_time: 3,
      popularity: 5,
      memo: "手縫いは結構大変",
      picture: open("#{Rails.root}/public/images/production8.jpg"),
      materials_attributes: [
                                { name: "レザー", amount: "適量" },
                                { name: "スタッズ", amount: "適量" },
                                { name: "レザークラフト道具", amount: "適量" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "レザーカードケース",
      user_id: 3,
      description: "スターターセットを使い手縫いで作成！",
      material: 1500,
      tips: "穴を開けるときは上から真っ直ぐ叩く",
      reference: "https://www.leathercraft.jp/kits/stationery/pass-case-kit/list/",
      required_time: 1,
      popularity: 5,
      memo: "初めてだけど楽しくできた",
      picture: open("#{Rails.root}/public/images/production9.jpg"),
      materials_attributes: [
                                { name: "スターターセット", amount: "1つ" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "コンチョを変更してかっこいい財布へリメイク",
      user_id: 1,
      description: "コンチョとストラップを変え、格好よく変身！",
      material: 3000,
      tips: "付け替えるだけなので簡単です",
      reference: "http://www.arrow-tribe.com/",
      required_time: 1,
      popularity: 5,
      memo: "たまにオイルを塗ると経年変化がいい感じになる",
      picture: open("#{Rails.root}/public/images/production10.jpg"),
      materials_attributes: [
                                { name: "好きなコンチョ", amount: "1個" },
                                { name: "鹿紐", amount: "1本" },
                                { name: "好きなビーズ", amount: "適量" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "食器棚をカッティングシートでリメイク",
      user_id: 2,
      description: "100均のリメイクシートを貼るだけ！",
      material: 500,
      tips: "端から空気が入らないように貼るのがコツ",
      reference: "https://www.youtube.com/watch?v=esqajaeqdek",
      required_time: 2,
      popularity: 5,
      memo: "躊躇せずに貼った方がいいかも",
      picture: open("#{Rails.root}/public/images/production11.jpg"),
      materials_attributes: [
                                { name: "木目調のシート", amount: "5枚" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "シンプルなデスクを大理石調にリメイク",
      user_id: 3,
      description: "100均のリメイクシートを貼るだけ！",
      material: 400,
      tips: "端から空気が入らないように貼るのがコツ",
      reference: "https://www.youtube.com/watch?v=pwGqhCWgrC0",
      required_time: 2,
      popularity: 5,
      memo: "躊躇せずにに貼った方がいいかも",
      picture: open("#{Rails.root}/public/images/production12.jpg"),
      materials_attributes: [
                                { name: "大理石調シート", amount: "4枚" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "スケボーのトリックBOX",
      user_id: 1,
      description: "ツーバイフォーとコンパネでボックス作り、鉄アングルをコーキングで固定",
      material: 5000,
      tips: "ホームセンターで必要な長さに切ってもらうとラク！",
      reference: "https://www.youtube.com/watch?v=dpHzrLoCpek",
      required_time: 5,
      popularity: 3,
      memo: "一人で作るのは結構大変だった",
      picture: open("#{Rails.root}/public/images/production13.jpg"),
      materials_attributes: [
                                { name: "コンパネ(1,800✖️900✖️12)", amount: "1枚" },
                                { name: "２✖️４材(6ft)", amount: "3本" },
                                { name: "鉄アングル(1,800✖30✖️30)", amount: "1本" },
                                { name: "ビス(35mm,75mm)", amount: "適量" },
                                { name: "シーリング材", amount: "1本" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "ダイソーのジャグをお洒落にリメイク",
      user_id: 2,
      description: "スプレーで塗装して好きなステッカーを貼るだけ！",
      material: 1500,
      tips: "塗装したくないところはマスキングテープで養生！",
      reference: "https://monorebyu.com/archives/13906.html",
      required_time: 3,
      popularity: 4,
      memo: "擦れる部分はすぐに塗装が剥がれちゃう",
      picture: open("#{Rails.root}/public/images/production14.jpg"),
      materials_attributes: [
                                { name: "ダイソーのウォータージャグ", amount: "1つ" },
                                { name: "好きな色のスプレー", amount: "1本" },
                                { name: "ミッチャクロン", amount: "1本" },
                                { name: "ステッカー", amount: "1枚" },
                                { name: "マスキングテープ", amount: "1本" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    },
    {
      name: "折り畳みカフェテーブル",
      user_id: 3,
      description: "DODのテキーラレッグにワンバイ材を組み合わせるだけ！釘等で固定しないので家でもキャンプでも使えます！",
      material: 3500,
      tips: "２枚にスリットを入れることで天板を広く使える",
      reference: "https://www.misojicamp.com/entry/2019/01/19/tequila-leg",
      required_time: 5,
      popularity: 5,
      memo: "木材の切り口はやすりがけをした方がいい",
      picture: open("#{Rails.root}/public/images/production15.jpg"),
      materials_attributes: [
                                { name: "DODテキーラレッグS", amount: "1セット" },
                                { name: "１✖️６材(900mm)", amount: "5本" },
                                { name: "ブライワックス", amount: "1個" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" },
                                { name: "", amount: "" }
                              ],
    }
  ]
)

production3 = Production.find(3)
production6 = Production.find(6)
production12 = Production.find(12)
production13 = Production.find(13)
production14 = Production.find(14)
production15 = Production.find(15)

# お気に入り登録
user3.favorite(production13)
user3.favorite(production14)
user1.favorite(production15)
user2.favorite(production12)

# コメント
production15.comments.create(user_id: user1.id, content: "かっこいい！私も作ってみたい！")
production12.comments.create(user_id: user2.id, content: "簡単にお洒落に出来そう！")

# 通知
user3.notifications.create(user_id: user3.id, production_id: production15.id,
                           from_user_id: user1.id, variety: 1)
user3.notifications.create(user_id: user3.id, production_id: production15.id,
                           from_user_id: user1.id, variety: 2, content: "かっこいい！私も作ってみたい！")
user3.notifications.create(user_id: user3.id, production_id: production12.id,
                           from_user_id: user2.id, variety: 1)
user3.notifications.create(user_id: user3.id, production_id: production12.id,
                           from_user_id: user2.id, variety: 2, content: "簡単にお洒落に出来そう！")
# リスト
user3.list(production3)
user1.list(production15)
user3.list(production6)
user2.list(production12)

# ログ
Production.all.each do |production|
  Log.create!(production_id: production.id,
              content: production.memo)
end