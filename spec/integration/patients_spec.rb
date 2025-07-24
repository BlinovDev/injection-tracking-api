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
    end
  end

  path '/api/v1/patients/{id}' do
    get 'Show a patient' do
      tags 'Patients'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'Patient ID'

      response '200', 'patient found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 api_key: { type: :string }
               },
               required: ['id', 'name', 'api_key']

        let(:id) { Patient.create(name: 'Alice').id }

        run_test!
      end

      response '404', 'patient not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
