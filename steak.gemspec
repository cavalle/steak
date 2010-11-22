# encoding: utf-8
require "date"

Gem::Specification.new do |gem|
  gem.name    = 'steak'
  gem.version = '1.0.0'
  gem.date    = Date.today.to_s

  gem.summary     = "Minimalist acceptance testing on top of RSpec"
  gem.description = "If you are not in Rails but use RSpec, then Steak is just some aliases providing you with the language of acceptance testing (feature, scenario, background). If you are in Rails, you also have a couple of generators, a rake task and full Rails integration testing (meaning Webrat support, for instance)"

  gem.authors  = ["Luismi Cavallé"]
  gem.email    = 'luismi@lmcavalle.com'
  gem.homepage = 'http://github.com/cavalle/steak'

  gem.files = Dir['init.rb', 'MIT-LICENSE', 'Rakefile', 'README*', 'LICENSE*',
                  '{lib,spec,generators}/**/*'] & `git ls-files -z`.split("\0")

  gem.add_dependency 'rspec'
  
  gem.add_development_dependency 'rspec-rails', '>= 2.0.0'
  gem.add_development_dependency 'rails', '>= 3.0.0'
  gem.add_development_dependency 'capybara'
  gem.add_development_dependency 'webrat'
  gem.add_development_dependency 'sqlite3-ruby'
end
