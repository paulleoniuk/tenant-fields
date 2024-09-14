tenant = Tenant.create!(name: 'Demo Tenant')

users = User.create!(
  [
    { email: 'alice@example.com', tenant: tenant },
    { email: 'bob@example.com', tenant: tenant },
    { email: 'carol@example.com', tenant: tenant }
  ]
)

custom_fields = CustomField.create!(
  [
    { name: 'Phone Number', field_type: 'number', tenant: tenant  },
    { name: 'Favorite Color', field_type: 'single_select', tenant: tenant },
    { name: 'Interests', field_type: 'multiple_select', tenant: tenant }
  ]
)

users.each do |user|
  CustomFieldValue.create!(
    [
      { customizable: user, custom_field: custom_fields[0], value: { type: 'number', data: '1234567890' } },
      { customizable: user, custom_field: custom_fields[1], value: { type: 'single_select', data: 'Blue' } },
      { customizable: user, custom_field: custom_fields[2], value: { type: 'multiple_select', data: [ 'Reading', 'Traveling' ] } }
    ]
  )
end
