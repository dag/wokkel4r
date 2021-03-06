$: << (File.dirname(__FILE__) << "/../lib")
require 'rubygems'
require 'xmpp4r/client'
require 'wokkel/handler'
require 'wokkel/protocols/message'
require 'wokkel/protocols/roster'
require 'wokkel/protocols/presence'

class EchoBot < Wokkel::Handler
  include Wokkel::Protocols::Message
  include Wokkel::Protocols::Roster
  include Wokkel::Protocols::Presence

  def on_logged_in
    available
    get_roster
  end

  def on_message(msg)
    if msg.type == :chat && !msg.body.nil?
      send(msg.answer.set_type(msg.type).set_body(msg.body))
    end
  end

  def on_roster_get(items)
    items.each do |item|
      puts "%s is in your roster!" % item.jid
    end
  end

  def on_presence(prc)
    case prc.type
    when :subscribe
      send(prc.answer.set_type(:subscribed))
      send(prc.answer.set_type(:subscribe))
    when nil
      puts "%s is online!" % prc.from
    when :unavailable
      puts "%s is offline!" % prc.from
    end
  end
end

if __FILE__ == $0
  Jabber::debug = true
  client = Jabber::Client.new(Jabber::JID.new(ARGV[0]))
  echo = EchoBot.new(client)
  client.connect
  begin
    client.auth(ARGV[1])
  rescue Jabber::ClientAuthenticationFailure
    client.register(ARGV[1])
    client.auth(ARGV[1])
  end
  echo.on_logged_in
  Thread.stop
end
