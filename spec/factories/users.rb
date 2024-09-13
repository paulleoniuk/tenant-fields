FactoryBot.define do
  factory :user do
    email { "johndoe@gmail.com" }
    password_digest { "123123123" }
    association :tenant
  end
end
