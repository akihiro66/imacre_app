User.create!(name:  "山田 太郎",
            email: "sample@example.com",
            password:              "foobar",
            password_confirmation: "foobar",
            admin: true)

99.times do |n|
 name  = Faker::Name.name
 email = "sample-#{n+1}@example.com"
 password = "password"
 User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

10.times do |n|
  Production.create!(name: Faker::Commerce.product_name,
               description: "一人用のアンティークテーブルです。木材はSPF材と杉材を使っています。",
               material: 1.5,
               tips: "SPF材と杉材を組み合わせることで、コントラストをつけました",
               reference: "https://diy-recipe.com/recipe/3164/",
               required_time: 1,
               popularity: 5,
               memo: "初めて作った割にはうまくできた！",
               user_id: 1)
end
