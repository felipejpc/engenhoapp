class TestClass
  require "contentful"

  @@client = Contentful::Client.new(
      space: "h0hn2pnr1nct",
      access_token: "pGry8uBgtxMqy8Hhsk12sGDOsqWpnDc4DliWHpXuQ8w",
      environment: "master",
      dynamic_entries: :auto,
      raw_mode: true
  )
  # TODO: create a treatment for responses with over 1000 records next_page method.
  # See: https://www.contentful.com/developers/docs/references/content-delivery-api/
  # #/reference/synchronization/pagination-and-subsequent-syncs
  # TODO change sync approach for delta updates
  def self.run
    @query = @@client.entries(content_type: "blogPost", include: 10)
    file = @query.load_json.deep_symbolize_keys
    file[:items].each do |item|
      custom_json = ContentfulCustomJson.new(item, file[:includes])
      binding.pry
      p custom_json
    end
  end
end
