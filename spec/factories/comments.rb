FactoryBot.define do
  factory :comment do
    production_id { 1 }
    user_id { 1 }
    content { "MyText" }
  end
end
