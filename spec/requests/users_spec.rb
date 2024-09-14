require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "PATCH /users/:id/update_value" do
    let!(:user) { create(:user) }
    let!(:custom_field) { create(:custom_field) }

    context "when the request is valid" do
      before do
        patch "/users/#{user.id}/update_value", params: { custom_field_id: custom_field.id, value: "1234567890" }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
