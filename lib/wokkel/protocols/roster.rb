require 'wokkel/handler'
require 'xmpp4r/roster/iq/roster'

module Wokkel
  module Protocols
    class Roster < Handler
      def on_initialize
	@stream.add_iq_callback(&method(:on_iq))
      end

      def on_iq(iq)
	if iq.query.kind_of? Jabber::Roster::IqQueryRoster
	  iq.query.receive_iq(iq)
	  on_roster_get(iq.query.to_a)
	end
      end

      def on_roster_get(items)
      end
    end
  end
end
