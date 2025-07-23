require 'rails_helper'

describe "Patients API", type: :request do
  describe "GET /api/v1/patients/:id" do
    let!(:patient) { create(:patient) }

    it "returns the patient info" do
      get "/api/v1/patients/#{patient.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(patient.id)
    end

    it "returns 404 for non-existing patient" do
      get "/api/v1/patients/abc"

      expect(response).to have_http_status(:not_found)
    end
  end
end

