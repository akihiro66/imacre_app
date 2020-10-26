FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "作品に関しての質問等、気軽にコメント下さい！" }
    association :production
  end
end
