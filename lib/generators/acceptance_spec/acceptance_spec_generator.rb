require 'rails/generators'

class AcceptanceSpecGenerator < Rails::Generators::NamedBase
  def manifest
    empty_directory File.join('spec/acceptance', class_path)
    file_name.gsub!(/_spec$/,"")
    template 'acceptance_spec.rb', File.join('spec/acceptance', class_path, "#{file_name}_spec.rb")
  end
  
  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
end