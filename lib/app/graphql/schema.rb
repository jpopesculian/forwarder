require 'graphql'
require_relative 'query'

AppSchema = GraphQL::Schema.define do
  query QueryType
end
