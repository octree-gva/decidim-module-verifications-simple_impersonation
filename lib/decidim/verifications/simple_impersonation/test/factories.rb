# frozen_string_literal: true

require "decidim/faker/localized"
require "decidim/faker/internet"
require "decidim/dev"
require "decidim/core/test/factories"

FactoryBot.define do
  factory :simple_impersonation_config, class: "Decidim::Verifications::Simple_Impersonation::Config" do
    organization { create(:organization) }
  end
end
