require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:tenant) { create(:tenant) }
  let(:user) { create(:user, tenant: tenant) }
  let(:custom_field) { create(:custom_field, tenant: tenant) }

  describe 'PATCH #update_value' do
    context 'when the request is valid' do
      let(:valid_attributes) do
        {
          custom_field_id: custom_field.id,
          value: "1234567890" # Assuming the value is a string representing a number
        }
      end

      it 'updates the custom field value' do
        patch :update_value, params: { id: user.id, custom_field_id: custom_field.id, value: "1234567890" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Custom field updated successfully')
        expect(user.custom_field_values.first.value['value']).to eq(1234567890)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        {
          custom_field_id: custom_field.id,
          value: "" # Invalid value
        }
      end

      it 'returns an error message' do
        patch :update_value, params: { id: user.id, custom_field_id: custom_field.id, value: "" }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid number value')
      end
    end

    context 'when an exception is raised' do
      before do
        allow_any_instance_of(CustomFieldUpdater).to receive(:call).and_raise(StandardError.new('An unexpected error occurred'))
      end

      let(:valid_attributes) do
        {
          custom_field_id: custom_field.id,
          value: "1234567890"
        }
      end

      it 'handles the error gracefully' do
        patch :update_value, params: { id: user.id, custom_field_id: custom_field.id, value: "1234567890" }
        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)['error']).to eq('An unexpected error occurred')
      end
    end
  end
end
