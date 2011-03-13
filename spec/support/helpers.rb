require 'tempfile'

module Helpers
  def generate_rails_project
    FileUtils.rm_rf rails_project_path
    run "rails new #{rails_project_path} -OG"
    silence_warnings { Dir.chdir rails_project_path }
  end
  
  def append_to(path, content)
    rails_project_path.join(path).open('a') { |f| f.write content }
  end
  
  def run(command)
    output = Bundler.with_clean_env { `#{command} 2>&1` }
    
    log "$ #{command}"
    log output
    raise "`#{command}` failed with:\n#{output}" unless $?.success?
  end
  
  def path(path)
    rails_project_path.join(path)
  end
  
  def root_path
    Pathname.new(__FILE__).join('../../..')
  end
  
  def rails_project_path
    Pathname.new(Dir.tmpdir).join('rails_project')
  end
  
  def log(text)
    puts text if ENV['TRACE']
  end
end

RSpec.configuration.include Helpers