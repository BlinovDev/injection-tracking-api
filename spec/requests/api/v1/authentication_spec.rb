require 'rails_helper'

describe "API Key Authentication", type: :request do
  let(:patient) { create(:patient) }
  let(:headers) { { "Authorization" => "Bearer #{patient.api_key}" } }
  let(:invalid_headers) { { "Authorization" => "Bearer invalidapikey" } }

  shared_examples "unauthorized request" do
    it "returns 401 Unauthorized with error message" do
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to include("Invalid API key")
    end
  end

  describe "GET /api/v1/patients/:id/adherence" do
    let(:url) { "/api/v1/patients/#{patient.id}/adherence?drug_name=Adynovate" }

    before do
      patient.schedules.create!(interval_in_days: 3, drug_name: "Adynovate", starts_on: Date.today)
    end

    it "allows access with valid api_key" do
      get url, headers: headers

      expect(response).to have_http_status(:ok)
    end

    context "when api_key is missing" do
      before { get url }

      it_behaves_like "unauthorized request"
    end

    context "when api_key is invalid" do
      before { get url, headers: invalid_headers }

      it_behaves_like "unauthorized request"
    end
  end
end
