module ForwarderApp
  class Handler
    def self.call(env = nil)
      log(env)
      handler(env).(env)
    end

    def self.handler(env)
      Ws::Handler.should_handle?(env) ? Ws::Handler : Http::Handler
    end

    def self.log(env)
      request = Rack::Request.new(env)
      puts '======================'
      puts request.request_method
      puts request.url
      puts request.body.string rescue nil
      puts '======================'
    end
  end
end
