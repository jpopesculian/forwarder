require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'rack/contrib'
require 'faye/websocket'

require 'forwarder_schema'
require 'forwarder_host'
require 'server/client'

require_relative 'forwarder_app/http/handler'

require_relative 'forwarder_app/ws/graphql/message_types'
require_relative 'forwarder_app/ws/graphql/message'
require_relative 'forwarder_app/ws/handler'

require_relative 'forwarder_app/handler'
