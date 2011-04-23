# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "steak/version"

Gem::Specification.new do |s|
  s.name        = "steak"
  s.version     = Steak::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = Date.today.to_s

  s.authors     = ["Luismi Cavallé"]
  s.email       = "luismi@lmcavalle.com"
  s.homepage    = "http://github.com/cavalle/steak"

  s.summary     = %q{The delicious combination of RSpec and Capybara for Acceptance BDD}
  s.description = %q{Steak is a minimal extension of RSpec-Rails that adds several conveniences to do acceptance testing of Rails applications using Capybara. It's an alternative to Cucumber in plain Ruby.}
  s.has_rdoc    = false

  s.files       = Dir['LICENSE', 'README.md', 'lib/**/*'] & `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- spec/**/*`.split("\n")

  s.add_dependency  'rspec-rails', '>= 2.5.0'
  # s.add_dependency  'capybara', '>= 1.0.0'

end
