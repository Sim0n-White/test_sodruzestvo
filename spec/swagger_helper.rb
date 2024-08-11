# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.to_s + '/swagger'

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          author: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string }
            },
            required: ['id', 'name']
          },
          course: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              description: { type: :text },
              author_id: { type: :integer }
            },
            required: ['id', 'title', 'description', 'author_id']
          },
          competency: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :text }
            },
            required: ['id', 'name', 'description']
          }
        }
      }
    }
  }

  config.openapi_format = :yaml
end
