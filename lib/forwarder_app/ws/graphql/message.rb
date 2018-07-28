module ForwarderApp
  module Ws
    module GraphQL
      class Message
        def initialize(event)
          @data = JSON.parse(event.data).symbolize_keys
        end

        def type
          data[:type]
        end

        def payload
          Payload.new(data)
        end

        class Payload
          def initialize(data)
            @data = data[:payload].symbolize_keys
          end

          def query
            data[:query]
          end

          def variables
            data[:variables]
          end

          def operation_name
            data[:operationName]
          end

          private

          attr_reader :data
        end

        private

        attr_reader :data
      end
    end
  end
end
