require 'tempfile'

module Helpers
  attr_accessor :output
  
  def generate_rails_project
    rm_rf rails_project_path
    cd # go to an existing dir
    run "rails new #{rails_project_path}"
    cd rails_project_path
  end
  
  def generate_rails_project_with_steak
    generate_rails_project
    
    append_to 'Gemfile', <<-RUBY
      group(:test) do 
        gem 'steak', :path => '#{root_path}'
        gem 'capybara', :path => '#{Bundler.load.specs['capybara'].first.full_gem_path}' # Totally temporal. It should be a steak dependency
      end
    RUBY
    
    run 'bundle --local'
    run 'rails g steak:install'
  end
  
  def append_to(path, content)
    rails_project_path.join(path).open('a') { |f| f.write content }
  end
  
  def run(command)
    self.output = Bundler.with_clean_env { `#{command} 2>&1` }
    
    log "$ #{command}"
    log self.output
    raise "`#{command}` failed with:\n#{output}" unless $?.success?
  end
  
  def path(path)
    rails_project_path.join(path)
  end
  
  def content_of(path)
    File.read path(path)
  end
  
  def cd(*args)
    silence_warnings { Dir.chdir(*args) }
  end
  
  def rm_rf(*args)
    FileUtils.rm_rf *args
  end
  
  def root_path
    Bundler.root
  end
  
  def rails_project_path
    Pathname.new(Dir.tmpdir).join('rails_project')
  end
  
  def log(text)
    puts text if ENV['TRACE']
  end
end

RSpec.configuration.include Helpers