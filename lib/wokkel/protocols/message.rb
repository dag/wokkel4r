require 'wokkel/handler'

module Wokkel
  module Protocols
    class Message < Handler
      def on_initialize
        @stream.add_message_callback(&method(:on_message))
      end

      def on_message(msg)
      end
    end
  end
end
