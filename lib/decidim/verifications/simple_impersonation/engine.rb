# frozen_string_literal: true

require 'rails'
require 'decidim/core'
require 'decidim/verifications'

require 'active_support/all'
module Decidim
  module Verifications
    module SimpleImpersonation
      # This is the engine that runs on the public interface of simple impersonation.
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Verifications::SimpleImpersonation

        initializer 'decidim_verifications_simple_impersonation.add_cells_view_paths' do |_app|
          Cell::ViewModel.view_paths << File.expand_path(
            "#{Decidim::Verifications::SimpleImpersonation::Engine.root}/app/views"
          )
        end

        initializer 'decidim_verifications_simple_impersonation.webpacker.assets_path' do
          Decidim.register_assets_path File.expand_path(
            "#{Decidim::Verifications::SimpleImpersonation::Engine.root}/app/packs"
          )
        end
      end
    end
  end
end
