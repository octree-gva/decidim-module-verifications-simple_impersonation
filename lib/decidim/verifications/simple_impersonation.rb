# frozen_string_literal: true

require_relative "simple_impersonation/version"
require_relative "simple_impersonation/engine"
require_relative "simple_impersonation/workflow"

module Decidim
  module Verifications
    # This namespace holds the logic of the `SimpleImpersonation` component.
    module SimpleImpersonation
      class Error < StandardError; end
    end
  end
end
