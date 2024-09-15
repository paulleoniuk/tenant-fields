require 'rails_helper'

RSpec.describe Tenant, type: :model do
  describe '#create_custom_field' do
    let(:tenant) { create(:tenant) }

    context 'when valid parameters are provided' do
      it 'creates a custom field successfully' do
        custom_field = tenant.create_custom_field(name: 'Phone', field_type: 'number')

        expect(custom_field).to be_persisted
        expect(custom_field.name).to eq('Phone')
        expect(custom_field.field_type).to eq('number')
      end

      it 'creates a custom field with options' do
        custom_field = tenant.create_custom_field(name: 'Status', field_type: 'single_select', options: [ 'Active', 'Inactive' ])

        expect(custom_field).to be_persisted
        expect(custom_field.name).to eq('Status')
        expect(custom_field.field_type).to eq('single_select')
        expect(custom_field.options).to eq([ 'Active', 'Inactive' ])
      end
    end

    context 'when invalid parameters are provided' do
      it 'raises an error if name is missing' do
        expect {
          tenant.create_custom_field(name: '', field_type: 'single_select', options: [ 'Active', 'Inactive' ])
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
      end

      it 'raises an error if field_type is invalid' do
        expect {
          tenant.create_custom_field(name: 'Status', field_type: '', options: [ 'Active', 'Inactive' ])
        }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Field type can't be blank, Field type is not included in the list")
      end
    end
  end
end
