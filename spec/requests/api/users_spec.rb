require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    get('list users') do
      tags 'Users'
      security [ bearerAuth: [] ]
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          email: { type: :string, format: :email },
          password: { type: :string },
          phone: { type: :string },
          dob: { type: :string, format: :date },
          gender: { type: :string },
          address: { type: :string },
          role: { type: :string }
        },
        required: [ 'first_name', 'last_name', 'email', 'password', 'dob', 'gender', 'address', 'role' ]
      }
      response(201, 'created') do
        let(:body) do
          {
            first_name: 'user',
            last_name: 'one',
            email: 'user@example.com',
            password: 'Admin!123',
            phone: '9812345678',
            dob: '1997-12-12',
            gender: 'm',
            address: 'kathmandu',
            role: 'super_admin'
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      tags 'Users'
      produces 'application/json'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          phone: { type: :string },
          dob: { type: :string, format: :date },
          gender: { type: :string },
          address: { type: :string }
        },
        required: [ 'first_name', 'last_name', 'dob', 'gender', 'address' ]
      }
      response(200, 'successful') do
        let(:body) do
                    {
            first_name: 'user',
            last_name: 'one updated',
            phone: '9812345675',
            dob: '1997-11-12',
            gender: 'f',
            address: 'kathmandu'
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete user') do
      tags 'Users'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
