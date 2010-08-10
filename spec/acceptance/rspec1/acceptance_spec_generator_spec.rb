require File.dirname(__FILE__) + "/acceptance_helper.rb"

feature "Acceptance spec generator for rails", %q{
  In order to quickly add a new acceptance spec
  As a developer
  I want to run a generator that creates it for me
} do

  background do
    @rails_app = create_rails_app
  end

  scenario "Adding new acceptance spec" do
    Dir.chdir @rails_app do
      `script/generate acceptance_spec document_creation`
    end

    File.exist?(@rails_app + "/spec/acceptance/document_creation_spec.rb").should be_true
  end

  scenario "Adding new acceptance spec (plural name)" do
    Dir.chdir @rails_app do
      `script/generate acceptance_spec creating_documents`
    end

    File.exist?(@rails_app + "/spec/acceptance/creating_documents_spec.rb").should be_true
  end

  scenario "Adding new acceptance spec (pascalized name)" do
    Dir.chdir @rails_app do
      `script/generate acceptance_spec DocumentCreation`
    end

    File.exist?(@rails_app + "/spec/acceptance/document_creation_spec.rb").should be_true
  end

  scenario "Adding new acceptance spec (name ending with _spec)" do
    Dir.chdir @rails_app do
      `script/generate acceptance_spec document_creation_spec`
    end

    File.exist?(@rails_app + "/spec/acceptance/document_creation_spec.rb").should be_true
  end
end
