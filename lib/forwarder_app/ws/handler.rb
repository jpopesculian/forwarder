module ForwarderApp
  module Ws
    class Handler
      include GraphQL::MessageTypes

      def self.call(env)
        build.call(env)
      end

      def self.build
        new
      end

      def self.should_handle?(env)
        Faye::WebSocket.websocket?(env)
      end

      def call(env)
        @ws = Faye::WebSocket.new(env)
        @subscriptions = []
        connect
        async_response
      end

      def send_result(id = nil, payload = nil)
        send_message(GQL_DATA, id, payload)
      end

      def send_error(id = nil, payload = nil)
        send_message(GQL_ERROR, id, payload)
      end

      private

      attr_reader :ws
      attr_reader :subscriptions

      def on_open(event)
      end

      def on_message(event)
        message = GraphQL::Message.new(event)
        case message.type
        when GQL_CONNECTION_INIT
          # TODO implement keep alive? (need async timer to send keep alive messages)
          send_message GQL_CONNECTION_ACK
        when GQL_CONNECTION_TERMINATE
          ws.close
        when GQL_START
          payload = message.payload
          result = ForwarderSchema::Schema.execute(
            payload.query,
            variables: payload.variables,
            operation_name: payload.operation_name,
            context: {
              current_user: nil,
              request: event,
              connection: Connection.new(self, message)
            }
          )
          if result.context[:subscription_id]
            subscriptions << result.context[:subscription_id]
          end
          send_result nil, result
        else
          send_error
        end
      end

      def on_close(event)
        # subscriptions.each do |subscription_id|
        #   ForwarderSchema::Schema.subscriptions.delete_subscription(subscription_id)
        # end
      end

      def on_error(event)
      end

      def send_message(type, id = nil, payload = nil)
        ws.send(JSON.dump(id: id, type: type, payload: payload))
      end

      def connect
        [:open, :message, :close, :error].each do |event_type|
          ws.on(event_type) do |event|
            send "on_#{event_type}", event
          end
        end
      end

      def async_response
        ws.rack_response
      end
    end
  end
end
