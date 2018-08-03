module ForwarderApp
  module Ws
    class Connection
      def initialize(socket, message)
        @socket = socket
        @id = message.id
      end

      def transmit(object)
        @socket.send_result(@id, object.to_h)
      end

      def close
        @socket.close
      rescue
        nil
      end
    end
  end
end
