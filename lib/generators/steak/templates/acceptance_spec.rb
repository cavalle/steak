require File.dirname(__FILE__) + '/<%= @relative_path %>acceptance_helper'

feature "<%= @feature_name %>", %q{
  In order to ...
  As a ...
  I want to ...
} do

  scenario "Scenario name" do
    true.should == true
  end
end
