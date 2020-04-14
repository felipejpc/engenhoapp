# frozen_string_literal: true

class ContentfulSyncLocalDb
  require "contentful"

  @@client = Contentful::Client.new(
    space: "h0hn2pnr1nct",
    access_token: "pGry8uBgtxMqy8Hhsk12sGDOsqWpnDc4DliWHpXuQ8w",
    environment: "master",
    dynamic_entries: :auto
  )

  @@client_raw_mode = Contentful::Client.new(
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
    Blog::PostsTags.delete_all
    Blog::Post.delete_all
    Blog::Tag.delete_all
    Blog::Category.delete_all
    Page.delete_all
    Layout.delete_all

    tags = @@client.entries(content_type: "postTag", include: 2)
    tags.each do |tag|
      Blog::Tag.new(contentful_id: tag.id, tag_name: tag.tag).save
    end

    categories = @@client.entries(content_type: "postCategory", include: 2)
    categories.each do |category|
      Blog::Category.new(contentful_id: category.id, name: category.name).save
    end

    posts = @@client_raw_mode.entries(content_type: "blogPost", include: 2).load_json.deep_symbolize_keys
    posts[:items].each do |post|
      post_json = ContentfulCustomJson.new(post, posts[:includes])
      post_category = Blog::Category.find_by(contentful_id: post[:fields][:category][:sys][:id])
      post_in_db = post_category.posts.create(contentful_id: post[:sys][:id], slug: post[:fields][:slug],
                                              json: post_json)
      post_json.custom_json[:fields][:tags].each do |tag|
        post_tag = Blog::Tag.find_by(tag_name: tag[:tag])
        Blog::PostsTags.create(post_id: post_in_db.id, tag_id: post_tag.id)
      end
    end

    blog_pages = @@client_raw_mode.entries(content_type: "blogPage", include: 2).load_json.deep_symbolize_keys
    blog_pages[:items].each do |page|
      Blog::BlogPage.create(slug: page[:fields][:slug], contentful_id: page[:sys][:id])
    end

    layouts = @@client_raw_mode.entries(content_type: "blogLayout", include: 2).load_json.deep_symbolize_keys
    layouts[:items].each do |layout|
      Layout.create(name: layout[:fields][:name], contentful_id: layout[:sys][:id],
                    json: ContentfulCustomJson.new(layout, layouts[:includes]))
    end
  end
end
