# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe "decidim/verifications/authorizations/new" do
    let(:handler) do
      DummyAuthorizationHandler.new({})
    end

    let(:organization) { double(cta_button_path: "/") }

    before do
      view.extend AuthorizationFormHelper
      view.extend DecidimFormHelper
      view.extend CtaButtonHelper
      view.extend ScopesHelper
      allow(view).to receive_messages(current_organization: organization, handler:, params: { handler: "dummy_authorization_handler" }, authorizations_path: "/authorizations", stored_location: "/processes", redirect_url: "/")
    end

    it "renders the form from the partial" do
      expect(render).to have_css("[data-partial-demo]")
    end

    it "renders the button separately" do
      expect(render).to have_tag("button[type=submit]", count: 1)
    end

    context "when handler is admin-only" do
      before do
        allow(handler).to receive(:respond_to?).with(:admin_only?).and_return(true)
        allow(handler).to receive(:admin_only?).and_return(true)
        render
      end

      it "displays the handler's title" do
        expect(rendered).to have_css("h1.title-decorator", text: I18n.t("sample_handler.name", scope: "decidim.authorization_handlers"))
      end

      it "displays the admin-only explanation" do
        expect(rendered).to have_text(I18n.t("sample_handler.admin_only_explanation", scope: "decidim.authorization_handlers"))
      end
    end

    context "when handler is not admin-only" do
      before do
        allow(handler).to receive(:respond_to?).with(:admin_only?).and_return(false)
        render
      end

      it "displays the authorization form" do
        expect(rendered).to have_css("form")
      end

      it "displays the authorization button" do
        expect(rendered).to have_button(I18n.t("decidim.verifications.authorizations.new.authorize"))
      end
    end
  end
end
