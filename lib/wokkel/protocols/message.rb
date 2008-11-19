module Wokkel
  module Protocols
    module Message
      def on_initialize
        super
        @stream.add_message_callback(&method(:on_message))
      end

      def on_message(msg)
      end
    end
  end
end
