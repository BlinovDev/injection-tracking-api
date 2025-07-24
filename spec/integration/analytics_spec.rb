require 'swagger_helper'

RSpec.describe 'Patients analytics API', type: :request do
  path '/api/v1/patients/{patient_id}/adherence' do
    get 'Patient adherence statistics' do
      tags 'Patients'
      produces 'application/json'

      parameter name: :patient_id, in: :path, type: :string
      parameter name: :drug_name, in: :query, type: :string, required: true
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'Bearer API key'

      response '200', 'statistics retrieved' do
        schema type: :object,
               properties: {
                 drug_name: { type: :string },
                 interval_in_days: { type: :integer },
                 starts_on: { type: :string, format: 'date' },
                 expected_injections: { type: :integer },
                 actual_injections: { type: :integer },
                 on_time_injections: { type: :integer },
                 adherence_score: { type: :number }
               },
               required: ['drug_name', 'interval_in_days', 'starts_on', 'expected_injections', 'actual_injections', 'on_time_injections', 'adherence_score']

        let(:patient) { Patient.create(name: 'Alice') }
        let(:patient_id) { patient.id }
        let(:Authorization) { "Bearer #{patient.api_key}" }
        let(:drug_name) { patient.schedules.first.drug_name }

        run_test!
      end

      response '404', 'schedule not found' do
        let(:patient) { Patient.create(name: 'Alice') }
        let(:patient_id) { patient.id }
        let(:Authorization) { "Bearer #{patient.api_key}" }
        let(:drug_name) { 'Unknown' }

        run_test!
      end
    end
  end

  path '/api/v1/patients/{patient_id}/injections_schedule' do
    get 'Patient injections schedule' do
      tags 'Patients'
      produces 'application/json'

      parameter name: :patient_id, in: :path, type: :string
      parameter name: :drug_name, in: :query, type: :string, required: true
      parameter name: :Authorization, in: :header, type: :string, required: true, description: 'Bearer API key'

      response '200', 'schedule retrieved' do
        schema type: :object,
               properties: {
                 drug_name: { type: :string },
                 interval_in_days: { type: :integer },
                 starts_on: { type: :string, format: 'date' },
                 injections: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       drug_name: { type: :string },
                       dose: { type: :number },
                       lot_number: { type: :string },
                       injected_at: { type: :string, format: 'date-time' }
                     },
                     required: ['id', 'drug_name', 'dose', 'lot_number', 'injected_at']
                   }
                 }
               },
               required: ['drug_name', 'interval_in_days', 'starts_on', 'injections']

        let(:patient) { Patient.create(name: 'Alice') }
        let(:patient_id) { patient.id }
        let(:Authorization) { "Bearer #{patient.api_key}" }
        let(:drug_name) { patient.schedules.first.drug_name }

        run_test!
      end
    end
  end
end
