require './lib/forwarder_app'

warmup do |app|
  ForwarderSchema::Start.()
  fork do
    ForwarderHost::Start.()
  end
end

run ForwarderApp::Handler
