module ForwarderApp
  module Ws
    module GraphQL
      module MessageTypes

        GQL_CONNECTION_INIT = 'connection_init'
        GQL_CONNECTION_ACK = 'connection_ack'
        GQL_CONNECTION_ERROR = 'connection_error'
        GQL_CONNECTION_KEEP_ALIVE = 'ka'
        GQL_CONNECTION_TERMINATE = 'connection_terminate'
        GQL_START = 'start'
        GQL_DATA = 'data'
        GQL_ERROR = 'error'
        GQL_COMPLETE = 'complete'
        GQL_STOP = 'stop'

      end
    end
  end
end
