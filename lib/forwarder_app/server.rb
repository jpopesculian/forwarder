module ForwarderApp
  class Server
    def self.call(env = nil)
      server(env).(env)
    end

    def self.server(env)
      Ws::Server.should_handle?(env) ? Ws::Server : Http::Server
    end
  end
end
