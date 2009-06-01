require 'rubygems'
require 'spec'
require 'tempfile'
require File.dirname(__FILE__) + "/../../lib/pickle"

feature "Acceptance spec execution", %q{
  In order to write better software
  As a developer
  I want to execute acceptance specs
} do
  
  scenario "Minimal acceptance spec" do
    spec_file = Tempfile.new("spec")
    File.open(spec_file.path, "w") do |file|
      file.write <<-EOF
      require '#{File.dirname(__FILE__) + "/../../lib/pickle"}'  
      feature "Minimal spec" do
        scenario "First scenario" do
          true.should be_true
        end
      end
      EOF
    end
    output = `spec #{spec_file.path} 2>&1`
    output.should =~ /1 example, 0 failures/
  end
  
  scenario "Minimal acceptance spec that fails" do
    spec_file = Tempfile.new("spec")
    File.open(spec_file.path, "w") do |file|
      file.write <<-EOF
      require '#{File.dirname(__FILE__) + "/../../lib/pickle"}'  
      feature "Minimal spec" do
        scenario "First scenario" do
          true.should be_false
        end
      end
      EOF
    end
    output = `spec #{spec_file.path} 2>&1`
    output.should =~ /1 example, 1 failure/
  end
  
  scenario "Acceptance spec with background" do
    spec_file = Tempfile.new("spec")
    File.open(spec_file.path, "w") do |file|
      file.write <<-EOF
      require '#{File.dirname(__FILE__) + "/../../lib/pickle"}'  
      feature "Minimal spec" do
        background do
          @value = 17
        end
        scenario "First scenario" do
          @value.should == 17
        end
      end
      EOF
    end
    output = `spec #{spec_file.path} 2>&1`
    output.should =~ /1 example, 0 failures/
  end
  
end