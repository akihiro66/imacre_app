FactoryBot.define do
  factory :production do
    name { Faker::Commerce.product_name }
    description { "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。" }
    material { 1.5 }
    tips { "SPF材と杉材を組み合わせることで、コントラストをつけました" }
    reference { "https://diy-recipe.com/recipe/3164/" }
    required_time { 1 }
    popularity { 5 }
    association :user
    created_at { Time.current }
  end

  trait :materials do
    materials_attributes {
                             [
                               { name: "木材A", amount: "1本" },
                               { name: "木材B", amount: "2本" },
                               { name: "木材C", amount: "3本" },
                               { name: "木材D", amount: "4本" },
                               { name: "木材E", amount: "5本" },
                               { name: "木材F", amount: "6本" },
                               { name: "木材G", amount: "7本" },
                               { name: "木材H", amount: "8本" },
                               { name: "木材I", amount: "9本" },
                               { name: "木材J", amount: "10本" },
                             ]
    }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :picture do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_production.jpg')) } # rubocop:disable Metrics/LineLength
  end
end
