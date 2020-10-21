require 'rails_helper'

RSpec.describe Production, type: :model do
  let!(:production) { create(:production) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(production).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      production = build(:production, name: nil)
      production.valid?
      expect(production.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      production = build(:production, name: "あ" * 31)
      production.valid?
      expect(production.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が140文字以内であること" do
      production = build(:production, description: "あ" * 141)
      production.valid?
      expect(production.errors[:description]).to include("は140文字以内で入力してください")
    end

    it "コツ・ポイントが50文字以内であること" do
      production = build(:production, tips: "あ" * 51)
      production.valid?
      expect(production.errors[:tips]).to include("は50文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      production = build(:production, user_id: nil)
      production.valid?
      expect(production.errors[:user_id]).to include("を入力してください")
    end

    it "人気度が1以上でなければ無効な状態であること" do
      production = build(:production, popularity: 0)
      production.valid?
      expect(production.errors[:production]).to include("は1以上の値にしてください")
    end

    it "人気度が5以下でなければ無効な状態であること" do
      production = build(:production, popularity: 6)
      production.valid?
      expect(production.errors[:production]).to include("は5以下の値にしてください")
    end
  end
end
