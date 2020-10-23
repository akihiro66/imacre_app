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
