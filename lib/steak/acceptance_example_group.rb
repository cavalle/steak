module Steak  
  module AcceptanceExampleGroup
    extend ActiveSupport::Concern
    
    included do
      metadata[:type] = :acceptance
    end
  end
end