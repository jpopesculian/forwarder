require './lib/forwarder_app'

# TODO delete this
pg_settings = Settings.build('settings/message_store_postgres.json').get
PG::connect(pg_settings).exec('DELETE FROM messages')

warmup do |app|
  ForwarderSchema::Start.()
  fork do
    ForwarderHost::Start.()
  end
end

run ForwarderApp::Server
