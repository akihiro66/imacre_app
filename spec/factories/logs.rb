FactoryBot.define do
  factory :log do
    content { "材料の塗装を変えると面白いかも！" }
    association :production
  end
end
