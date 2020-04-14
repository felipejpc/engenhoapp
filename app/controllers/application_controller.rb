# frozen_string_literal: true

class ApplicationController < ActionController::Base
  require "contentful"

  def contentful
    @client = Contentful::Client.new(
      access_token: "pGry8uBgtxMqy8Hhsk12sGDOsqWpnDc4DliWHpXuQ8w",
      space: "h0hn2pnr1nct"
    )
  end

  def layout_data(layout)
    @layout_data = Layout.find_by(name: layout)
    binding.pry
  end
end
