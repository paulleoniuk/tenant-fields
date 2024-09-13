FactoryBot.define do
  factory :custom_field do
    name { "Phone Number" }
    field_type { "number" }
    association :tenant
  end
end
