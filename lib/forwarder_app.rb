require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'rack/contrib'
require 'faye/websocket'

require 'forwarder_schema'
require 'forwarder_host'
require 'server/client'

require_relative 'forwarder_app/http/server'

require_relative 'forwarder_app/ws/graphql/message_types'
require_relative 'forwarder_app/ws/graphql/message'
require_relative 'forwarder_app/ws/server'

require_relative 'forwarder_app/server'
