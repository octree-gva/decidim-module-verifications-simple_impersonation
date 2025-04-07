# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe "decidim/verifications/authorizations/new", type: :view do
    let(:handler) do
      DummyAuthorizationHandler.new({})
    end

    let(:organization) { double(cta_button_path: "/") }

    before do
      view.extend AuthorizationFormHelper
      view.extend DecidimFormHelper
      view.extend CtaButtonHelper
      view.extend ScopesHelper
      allow(view).to receive(:current_organization).and_return(organization)
      allow(view).to receive(:handler).and_return(handler)
      allow(view).to receive(:params).and_return(handler: "dummy_authorization_handler")
      allow(view).to receive(:authorizations_path).and_return("/authorizations")
      allow(view).to receive(:stored_location).and_return("/processes")
      allow(view).to receive(:redirect_url).and_return("/")
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
        expect(rendered).to have_selector("h1.title-decorator", text: I18n.t("sample_handler.name", scope: "decidim.authorization_handlers"))
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
        expect(rendered).to have_selector("form")
      end

      it "displays the authorization button" do
        expect(rendered).to have_selector("button", text: I18n.t("decidim.verifications.authorizations.new.authorize"))
      end
    end
  end
end
