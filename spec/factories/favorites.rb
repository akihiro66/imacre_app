FactoryBot.define do
  factory :favorite do
    association :production
    association :user
  end
end
