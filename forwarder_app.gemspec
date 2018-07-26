# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'forwarder_app'
  s.version = '0.0.0'
  s.summary = 'Forwarder App'
  s.description = ' '

  s.authors = ['Julian Popescu']
  s.email = 'jpopesculian@gmail.com'
  s.homepage = ''
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir['lib/app/**/*', 'lib/app.rb']
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4'

  s.add_runtime_dependency 'sinatra'
  s.add_runtime_dependency 'sinatra-contrib'
  s.add_runtime_dependency 'puma'
  s.add_runtime_dependency 'rake'
  s.add_runtime_dependency 'rack-contrib'
  s.add_runtime_dependency 'twilio-ruby'
  s.add_runtime_dependency 'rack'
  s.add_runtime_dependency 'forwarder_host'
  s.add_runtime_dependency 'forwarder_schema'
  s.add_runtime_dependency 'server_client'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry'
end
