FactoryBot.define do
  factory :production do
    name { Faker::Name.production }
    description { "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。" }
    material { 1.5 }
    tips { "SPF材と杉材を組み合わせることで、コントラストをつけました" }
    reference { "https://diy-recipe.com/recipe/3164/" }
    required_time { 1 }
    popularity { 5 }
    association :user
  end
end
