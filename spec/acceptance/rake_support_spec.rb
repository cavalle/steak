require 'spec_helper'

feature 'Rake support', %q{
  In order to conveniently run my specs along with the rest of my test suite
  As a Rails developer
  I want rake support in Steak
} do

  background do
    new_project_from :rails_project_with_steak
    create_file 'spec/unit_spec.rb', <<-RSPEC
      require 'spec_helper'

      describe Object do
        it { should respond_to :to_s }
      end
    RSPEC
    run 'rails g steak:spec my_spec'
  end

  scenario 'to run acceptance specs as part of the test suite' do
    run 'rake spec'
    output.should =~ /2 examples, 0 failures/

    run 'rake'
    output.should =~ /2 examples, 0 failures/
  end

  scenario 'to run only acceptance specs' do
    run 'rake spec:acceptance'
    output.should =~ /1 example, 0 failures/
  end

end
