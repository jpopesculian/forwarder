require 'forwarder_host'
require './lib/app'

fork do
  ForwarderHost::Start.()
end

run App
