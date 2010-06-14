Gem::Specification.new do |gem|
  gem.name    = 'steak'
  gem.version = '0.4.0.beta.1'
  gem.date    = Date.today.to_s

  gem.summary     = "Minimalist acceptance testing on top of RSpec"
  gem.description = "If you are not in Rails but use RSpec, then Steak is just some aliases providing you with the language of acceptance testing (feature, scenario, background). If you are in Rails, you also have a couple of generators, a rake task and full Rails integration testing (meaning Webrat support, for instance)"

  gem.authors  = ["Luismi Cavallé"]
  gem.email    = 'luismi@lmcavalle.com'
  gem.homepage = 'http://github.com/cavalle/steak'

  gem.files = Dir['init.rb', 'MIT-LICENSE', 'Rakefile', 'README*', 'LICENSE*',
                  '{lib,spec}/**/*'] & `git ls-files -z`.split("\0")

  gem.add_dependency('rspec', '>= 2.0.0.beta.9')
end
