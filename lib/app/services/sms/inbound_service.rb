require 'twilio-ruby'

module Services
  module Sms
    class InboundService
      def self.build
        new(
          twilio: Twilio::REST::Client.new(
            App.settings.twilio['account_sid'],
            App.settings.twilio['auth_token'],
          ),
          forwarding_number: App.settings.twilio['forwarding_number'],
          recipient_number: App.settings.twilio['recipient_number']
        )
      end

      def initialize(twilio:, forwarding_number:, recipient_number:)
        @twilio = twilio
        @forwarding_number = forwarding_number
        @recipient_number = recipient_number
      end

      def call(message)
        send(forwarded_body(get_message(message["MessageSid"])))
      end

      private

      attr_reader :twilio
      attr_reader :forwarding_number
      attr_reader :recipient_number

      def send(body)
        twilio.messages.create(
          body: body,
          from: forwarding_number,
          to: recipient_number
        )
      end

      def get_message(message_sid)
        twilio.messages(message_sid).fetch
      end

      def forwarded_body(message)
        "From: #{message.from}\n#{message.body}"
      end
    end
  end
end
