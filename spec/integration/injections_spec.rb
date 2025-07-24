require 'swagger_helper'

RSpec.describe 'Injections API', type: :request do
  path '/api/v1/patients/{patient_id}/injections' do
    post 'Create an injection' do
      tags 'Injections'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :patient_id, in: :path, type: :string
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'Bearer API key'
      parameter name: :injection, in: :body, schema: {
        type: :object,
        properties: {
          injection: {
            type: :object,
            properties: {
              drug_name: { type: :string },
              dose: { type: :number },
              lot_number: { type: :string }
            },
            required: ['drug_name', 'dose', 'lot_number']
          }
        }
      }

      response '201', 'injection created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 drug_name: { type: :string },
                 dose: { type: :number },
                 lot_number: { type: :string },
                 injected_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'drug_name', 'dose', 'lot_number', 'injected_at']

        let(:patient) { Patient.create(name: 'Alice') }
        let(:patient_id) { patient.id }
        let(:Authorization) { "Bearer #{patient.api_key}" }
        let(:injection) { { injection: { drug_name: patient.schedules.first.drug_name, dose: 10, lot_number: '#12345' } } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:patient) { Patient.create(name: 'Bob') }
        let(:patient_id) { patient.id }
        let(:Authorization) { "Bearer #{patient.api_key}" }
        let(:injection) { { injection: { drug_name: patient.schedules.first.drug_name, dose: -1, lot_number: '#12345' } } }

        run_test!
      end
    end
  end
end
