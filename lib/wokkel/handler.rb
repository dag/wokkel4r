module Wokkel
  class Handler
    def initialize(stream)
      @stream = stream
      on_initialize
    end

    def send(*args)
      @stream.send(*args)
    end

    def on_initialize
    end
  end
end
