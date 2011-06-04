module Steak  
  module AcceptanceExampleGroup
    extend ActiveSupport::Concern
    
    included do
      metadata[:type] = :acceptance
    end
  end
end

RSpec.configuration.include Steak::AcceptanceExampleGroup, :capybara_feature => true