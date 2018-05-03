require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/config_file'
require 'sinatra/logger'
require 'rack/contrib'

require_relative 'models/speaker'
require_relative 'graphql/schema'
require_relative 'services/sms/inbound_service.rb'

class App < Sinatra::Base
  register Sinatra::ConfigFile
  configure :development do
    register Sinatra::Reloader
  end

  set :database_file, 'config/database.yml'
  config_file 'config/twilio.yml'
  use Rack::PostBodyContentTypeParser
  logger filename: "log/#{settings.environment}.log", level: :trace

  get '/' do
    'Hello World!'
  end

  post '/sms/inbound' do
    Services::Sms::InboundService.build.(params)
    halt 200
  end

  post '/voice/inbound' do
    binding.pry
  end

  post '/graphql' do
    result = AppSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    json result
  end
end
