require "rails_helper"

RSpec.describe "Libraries", type: :request do
  before :all do
    create(:library)
  end

  describe "GET /libraries" do
    it "redirects to the first available library" do
      get "/libraries"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /libraries/1" do
    it "returns http success" do
      get "/libraries/1"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /libraries/1?page=2" do
    it "returns paginated models" do
      allow(Rails.application.config).to receive(:paginate_models).and_return(true)
      get "/libraries/1?page=2"
      expect(response).to have_http_status(:success)
      expect(response.body).to match(/paginate-container/)
    end
  end
end
