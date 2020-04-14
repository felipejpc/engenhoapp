# frozen_string_literal: true
class ApplicationController < ActionController::Base
  layout :determine_layout
  require "contentful"

  def contentful
    @client = Contentful::Client.new(
      access_token: "pGry8uBgtxMqy8Hhsk12sGDOsqWpnDc4DliWHpXuQ8w",
      space: "h0hn2pnr1nct"
    )
  end

  def layout_data(layout)
    @layout_data = Layout.find_by(name: layout)
  end

  private

  def determine_layout
    params[:subdomain]
  end
end
