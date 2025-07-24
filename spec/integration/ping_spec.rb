require 'swagger_helper'

RSpec.describe 'Service ping', type: :request do
  path '/ping' do
    get 'Ping the service' do
      tags 'Health'
      produces 'application/json'

      response '200', 'service alive' do
        schema type: :object,
               properties: {
                 status: { type: :string }
               },
               required: ['status']

        run_test!
      end
    end
  end
end
