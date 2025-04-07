# frozen_string_literal: true

module Decidim
  module Verifications
    module SimpleImpersonation
      # This class is responsible for handling the authorization process to ensure that
      # only admin users can impersonate other users. It extends the `Decidim::AuthorizationHandler`
      # and adds a validation to check if the current user is an admin.
      #
      # If the current user is not an admin, an error message is added to the authorization
      # process, preventing the impersonation.
      class SimpleImpersonationHandler < Decidim::AuthorizationHandler
        validate :impersonate_from_admin?
        def admin_only?
          true
        end

        private

        def impersonate_from_admin?
          return false if current_user&.admin?

          errors.add(:base, I18n.t("decidim.authorization_handlers.simple_impersonation.errors.forbidden"))
        end
      end
    end
  end
end
