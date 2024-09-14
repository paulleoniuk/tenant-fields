FactoryBot.define do
  factory :user do
    email { "johndoe@gmail.com" }
    association :tenant
  end
end
