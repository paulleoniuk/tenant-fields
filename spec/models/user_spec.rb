require 'rails_helper'

RSpec.describe User, type: :model do
  let(:tenant) { create(:tenant) }
  let(:user) { create(:user, tenant: tenant) }

  describe '#get_custom_fields' do
    let!(:custom_field_1) { create(:custom_field, name: 'Age', field_type: 'number', tenant: tenant) }
    let!(:custom_field_2) { create(:custom_field, name: 'Gender', field_type: 'single_select', tenant: tenant) }

    let!(:custom_field_value_1) do
      create(
        :custom_field_value,
        customizable: user,
        custom_field: custom_field_1,
        value: { 'field_type' => 'number', 'data' => 25 }.to_json
      )
    end

    let!(:custom_field_value_2) do
      create(
        :custom_field_value,
        customizable: user,
        custom_field: custom_field_2,
        value: { 'field_type' => 'single_select', 'data' => 'Male' }.to_json
      )
    end

    it 'returns the correct custom field names and values' do
      custom_fields = user.get_custom_fields

      expect(custom_fields).to contain_exactly(
        { name: 'Age', value: { 'field_type' => 'number', 'data' => 25 } },
        { name: 'Gender', value: { 'field_type' => 'single_select', 'data' => 'Male' } }
      )
    end

    it 'returns an empty array if no custom fields exist' do
      user.custom_field_values.destroy_all

      expect(user.get_custom_fields).to eq([])
    end
  end
end
