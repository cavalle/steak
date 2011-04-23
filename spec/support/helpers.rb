require 'tempfile'

module Helpers
  
  def new_project_from(fixture_name)
    rm_rf rails_project_path
    cp_r fixture_path(fixture_name), rails_project_path
    cd rails_project_path
  end

  def append_to(path, content)
    rails_project_path.join(path).open('a') { |f| f.write content }
  end
  
  def create_file(path, content)
    rails_project_path.join(path).open('w') { |f| f.write content }
  end
  
  attr_accessor :output
  
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
  
  def cp_r(*args)
    FileUtils.cp_r *args
  end
  
  def root_path
    Bundler.root
  end
  
  def rails_project_path
    Pathname.new(Dir.tmpdir).join('rails_project')
  end
  
  def fixture_path(name = ".")
    root_path.join('spec', 'fixtures', name.to_s)
  end
  
  def log(text)
    puts text if ENV['TRACE']
  end

end

RSpec.configuration.include Helpers
