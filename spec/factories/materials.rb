FactoryBot.define do
  factory :material do
    name { "SPF材" }
    amount { "5本" }
    association :production
  end
end
