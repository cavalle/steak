module Steak
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(__FILE__), 'templates')

      def main
        generate    'rspec:install'
        directory   'spec/acceptance'
      end
    end
  end
end
