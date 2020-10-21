FactoryBot.define do
  factory :production do
    name { "MyString" }
    description { "MyText" }
    material { 1.5 }
    tips { "MyText" }
    reference { "MyText" }
    required_time { 1 }
    popularity { 1 }
    memo { "MyText" }
    user { nil }
  end
end
