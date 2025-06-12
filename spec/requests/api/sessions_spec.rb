require 'swagger_helper'

RSpec.describe 'API Login', type: :request do
  path '/api/login' do
    post 'User login' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'user@example.com' },
          password: { type: :string, example: 'password123' }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'login successful' do
        schema type: :object,
          properties: {
            token: { type: :string },
            user: {
              type: :object,
              properties: {
                id: { type: :integer },
                email: { type: :string }
                # add other user fields here as needed
              }
            }
          },
          required: [ 'token', 'user' ]

        let(:credentials) { { email: 'user@example.com', password: 'password123' } }
        run_test!
      end

      response '401', 'invalid credentials' do
        schema type: :object,
          properties: {
            error: { type: :string }
          },
          required: [ 'error' ]

        let(:credentials) { { email: 'wrong@example.com', password: 'badpassword' } }
        run_test!
      end
    end
  end
end
