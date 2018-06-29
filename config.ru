require './lib/app'

warmup do |app|
  ForwarderSchema::Start.()
  fork do
    ForwarderHost::Start.()
  end
end

run App
