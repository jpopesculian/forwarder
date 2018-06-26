require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sinatra/activerecord'
require 'sinatra/config_file'
require 'rack/contrib'

require_relative 'app/models/speaker'
require_relative 'app/graphql/schema'
require_relative 'app/services/sms/inbound_service.rb'
require_relative 'app/services/voice/inbound_service.rb'

class App < Sinatra::Base
  register Sinatra::ConfigFile
  configure :development do
    register Sinatra::Reloader
  end

  set :database_file, 'config/database.yml'
  config_file 'config/twilio.yml'
  use Rack::PostBodyContentTypeParser

  get '/' do
    'Hello World!'
  end

  post '/sms/inbound' do
    Services::Sms::InboundService.build.(params)
    halt 200
  end

  post '/voice/inbound' do
    Services::Voice::InboundService.build.()
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
