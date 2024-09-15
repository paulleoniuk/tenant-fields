FactoryBot.define do
  factory :custom_field_value do
    association :custom_field
    association :customizable, factory: :user
    value { { field_type: "number", data: "1234567890" } }
  end
end
