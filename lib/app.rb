require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'rack/contrib'

require 'forwarder_schema'
require 'forwarder_host'
require 'server/client'

# require_relative 'app/services/sms/inbound_service.rb'
require_relative 'app/services/voice/inbound_service.rb'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  use Rack::PostBodyContentTypeParser

  get '/' do
    'Hello World!'
  end

  post '/sms/inbound' do
    # SMe01b89516d5648b9a58501e7347d23d8
    Server::Client::SmsReceive.(
      message_sid: params[:MessageSid]
    )
    halt 200
  end

  post '/sms/status/:sms_id' do
    # SMe01b89516d5648b9a58501e7347d23d8
    Server::Client::SmsReceive.(
      sms_id: params[:sms_id],
      message_sid: params[:MessageSid]
    )
    halt 200
  end

  post '/voice/inbound' do
    Services::Voice::InboundService.build.()
  end

  post '/graphql' do
    result = ForwarderSchema::Schema.execute(
      params[:query],
      variables: params[:variables],
      context: {
        current_user: nil,
        request: request
      },
    )
    json result
  end
end
