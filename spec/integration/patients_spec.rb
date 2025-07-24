require 'swagger_helper'

RSpec.describe 'Patients API', type: :request do
  path '/api/v1/patients' do
    post 'Create a patient' do
      tags 'Patients'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :patient, in: :body, schema: {
        type: :object,
        properties: {
          patient: {
            type: :object,
            properties: {
              name: { type: :string }
            },
            required: ['name']
          }
        }
      }

      response '201', 'patient created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 api_key: { type: :string }
               },
               required: ['id', 'name', 'api_key']

        let(:patient) { { patient: { name: 'Alice' } } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:patient) { { patient: { name: '' } } }
        run_test!
      end
    end
  end
end
