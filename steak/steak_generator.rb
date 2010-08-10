class SteakGenerator < Rails::Generator::Base
  default_options :driver => 'capybara'

  def initialize(runtime_args, runtime_options = {})
    puts "Defaulting to Capybara..." if runtime_args.empty?
    super
  end

  def manifest
    record do |m|
      m.directory 'spec/acceptance/support'
      m.directory 'lib/tasks'
      m.template "acceptance_helper.rb", "spec/acceptance/acceptance_helper.rb"
      m.file "helpers.rb",               "spec/acceptance/support/helpers.rb"
      m.file "paths.rb",                 "spec/acceptance/support/paths.rb"
      m.file "steak.rake",               "lib/tasks/steak.rake"
    end
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on('--capybara', 'Use Capybara (default).') { |v| options[:driver] = 'capybara' }
    opt.on('--webrat', 'Use Webrat.') { |v| options[:driver] = 'webrat' }
  end
end
