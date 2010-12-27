module Spec::Example::ExampleGroupMethods
  alias scenario example
  alias background before
end

class << self
  alias feature describe 
end

if defined?(Spec::Rails)
  module Spec::Rails::Example
    class AcceptanceExampleGroup < IntegrationExampleGroup
      include ActionController::RecordIdentifier
      Spec::Example::ExampleGroupFactory.register(:acceptance, self)
    end
  end
end