require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /update_custom_field" do
    it "returns http success" do
      get "/users/update_custom_field"
      expect(response).to have_http_status(:success)
    end
  end

end
