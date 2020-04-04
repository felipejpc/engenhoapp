class ContentfulSyncLocalDb
  require 'contentful'

  @@client = Contentful::Client.new(
      space: 'h0hn2pnr1nct',
      access_token: 'pGry8uBgtxMqy8Hhsk12sGDOsqWpnDc4DliWHpXuQ8w',
      environment: 'master',
      dynamic_entries: :auto
  )
  # TODO create a treatment for responses with over 1000 records next_page method. See: https://www.contentful.com/developers/docs/references/content-delivery-api/#/reference/synchronization/pagination-and-subsequent-syncs
  # TODO change sync approach for delta updates
  def self.run
    Blog::PostsTags.delete_all
    Blog::Post.delete_all
    Blog::Tag.delete_all
    Blog::Category.delete_all
    Blog::Page.delete_all

    tags = @@client.entries(content_type: 'postTag', include: 2)
    tags.each do |tag|
      Blog::Tag.new(contentful_id: tag.id, tag_name: tag.tag).save
    end

    categories = @@client.entries(content_type: 'postCategory', include: 2)
    categories.each do |category|
      Blog::Category.new(contentful_id: category.id, name: category.name).save
    end

    posts = @@client.entries(content_type: 'blogPost', include: 2)
    posts.each do |post|
      post_category = Blog::Category.find_by(contentful_id: post.category.id)
      post_in_db = post_category.posts.create(contentful_id: post.id, title: post.title, slug: post.slug, description: post.description, thumb_image: post.thumb_image.url)
      post.tags.each do |tag|
        post_tag = Blog::Tag.find_by(contentful_id: tag.id)
        Blog::PostsTags.create(post_id: post_in_db.id, tag_id: post_tag.id)
      end
    end

    pages = @@client.entries(content_type: 'blogPage', include: 2)
    pages.each do |page|
      Blog::Page.create(title: page.title, slug: page.slug, body: page.body, contentful_id: page.id)
    end
  end
end
