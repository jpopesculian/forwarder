require 'twilio-ruby'

module Services
  module Voice
    class InboundService
      def self.build
        new(
          recipient_number: App.settings.twilio['recipient_number']
        )
      end

      def initialize(recipient_number:)
        @recipient_number = recipient_number
      end

      def call()
        dial_recipient(create_response).to_s
      end

      private

      attr_reader :recipient_number

      def dial_recipient(response)
        response.dial do |dial|
          dial.number(recipient_number)
        end
        response
      end

      def create_response
        Twilio::TwiML::VoiceResponse.new
      end
    end
  end
end
