require 'wokkel/handler'

module Wokkel
  module Protocols
    class Presence < Handler
      def on_initialize
	@stream.add_presence_callback(&method(:on_presence))
      end

      def on_presence(prc)
      end
    end
  end
end
