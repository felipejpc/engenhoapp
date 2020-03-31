class ContentfulSyncLocalDb
  require 'contentful'

  @@client = Contentful::Client.new(
      space: 'h0hn2pnr1nct',
      access_token: 'pGry8uBgtxMqy8Hhsk12sGDOsqWpnDc4DliWHpXuQ8w',
      environment: 'master',
      dynamic_entries: :auto
  )
  # TODO create a treatment for responses with over 1000 records next_page method. See: https://www.contentful.com/developers/docs/references/content-delivery-api/#/reference/synchronization/pagination-and-subsequent-syncs
  # TODO refactor methods to dry code
  # TODO change sync approach for delta updates
  def self.run
    Post.delete_all
    Tag.delete_all

    posts = @@client.entries(content_type: 'blogPost', include: 2)
    posts.each do |post|
      Post.new(contentful_id: post.id, title: post.title, slug: post.slug, description: post.description).save
      post.tags.each do |tag|
        PostsTags.create(post_id: post.id, tag_id: tag.id)
      end
    end

    tags = @@client.entries(content_type: 'postTag', include: 2)
    tags.each do |tag|
      Tag.new(contentful_id: tag.id, tag_name: tag.tag).save
    end
  end
end
