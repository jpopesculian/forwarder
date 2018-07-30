module ForwarderApp
  class Handler
    def self.call(env = nil)
      handler(env).(env)
    end

    def self.handler(env)
      Ws::Handler.should_handle?(env) ? Ws::Handler : Http::Handler
    end
  end
end
