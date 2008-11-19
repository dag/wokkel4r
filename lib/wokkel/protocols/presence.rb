module Wokkel
  module Protocols
    module Presence
      def on_initialize
        super
        @stream.add_presence_callback(&method(:on_presence))
      end

      def on_presence(prc)
      end
    end
  end
end
