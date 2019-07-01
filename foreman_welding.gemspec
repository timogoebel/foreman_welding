# frozen_string_literal: true

require File.expand_path('lib/foreman_welding/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'foreman_welding'
  s.version     = ForemanWelding::VERSION
  s.license     = 'GPL-3.0'
  s.authors     = ['Timo Goebel']
  s.email       = ['mail@timogoebel.name']
  s.homepage    = 'https://github.com/timogoebel/foreman_welding'
  s.summary     = 'Foreman plug-in that allows host logins via Foreman.'
  s.description = 'A Foreman plug-in that allows users to sign in to hosts with the ssh keys stored in Foreman.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'
end
