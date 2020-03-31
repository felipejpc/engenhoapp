class ContentfulPostsSynchronization
  require 'contentful'

  @@client = Contentful::Client.new(
      space: 'h0hn2pnr1nct',
      access_token: 'pGry8uBgtxMqy8Hhsk12sGDOsqWpnDc4DliWHpXuQ8w',
      environment: 'master',
      dynamic_entries: :auto
  )
  # TODO create a treatment for responses with over 1000 records next_page method. See: https://www.contentful.com/developers/docs/references/content-delivery-api/#/reference/synchronization/pagination-and-subsequent-syncs
  # TODO refactor methods to dry code
  def self.initial_sync_posts
    sync = @@client.sync(initial: true, content_type: 'blogPost', type: 'Entry')
    sync.each_item do |item|
      Post.new(content_id: item.id, title: item.title, slug: item.slug, description: item.description).save
    end
    Sync.new(content_type: 'blogPost', sync_type: 'initial entries', sync_token: sync.next_sync_url.nil? ? nil : sync.next_sync_url.split('sync_token=')[1]).save

    sync = @@client.sync(initial: true, type: 'Deletion')
    sync.each_item {|a| p a}
    Sync.new(content_type: 'blogPost', sync_type: 'initial deletion', sync_token: sync.next_sync_url.nil? ? nil : sync.next_sync_url.split('sync_token=')[1]).save
  end

  def self.delta_sync_posts
    sync = @@client.sync(sync_token: entries_sync_token)
    sync.each_item do |item|
      if new_entry? item.id
        Post.new(content_id: item.id, title: item.title, slug: item.slug, description: item.description).save
      else
        post = Post.find_by(content_id: item.id)
        post.update(title: item.title, slug: item.slug, description: item.description) unless post.nil?
      end
    end
    Sync.new(content_type: 'blogPost', sync_type: 'delta entries', sync_token: sync.next_sync_url.nil? ? nil : sync.next_sync_url.split('sync_token=')[1]).save


    sync = @@client.sync(sync_token: deletion_sync_token)
    unless sync.nil?
      sync.each_item do |item|
        post = Post.find_by(content_id: item.id)
        post.destroy unless post.nil?
      end
      Sync.new(content_type: 'blogPost', sync_type: 'delta deletion', sync_token: sync.next_sync_url.nil? ? nil : sync.next_sync_url.split('sync_token=')[1]).save
    end
  end

  private

  def self.new_entry?(content_id)
    Post.find_by(content_id: content_id).nil?
  end

  def self.entries_sync_token
    sync_registry = if Sync.where(content_type: 'blogPost', sync_type:'delta entries').last.nil?
                      Sync.where(content_type: 'blogPost', sync_type:'initial entries').last
                    else
                      Sync.where(content_type: 'blogPost', sync_type:'delta entries').last
                    end
    sync_registry.sync_token
  end

  def self.deletion_sync_token
    sync_registry = if Sync.where(content_type: 'blogPost', sync_type:'delta deletion').last.nil?
                      Sync.where(content_type: 'blogPost', sync_type:'initial deletion').last
                    else
                      Sync.where(content_type: 'blogPost', sync_type:'delta deletion').last
                    end
    sync_registry.sync_token
  end
end
