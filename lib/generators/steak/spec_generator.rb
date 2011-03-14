module Steak
  module Generators
    class SpecGenerator < Rails::Generators::NamedBase
      source_root File.join(File.dirname(__FILE__), 'templates')

      def main
        template 'acceptance_spec.rb', File.join('spec/acceptance', class_path, "#{file_name}_spec.rb")
      end
    end
  end
end