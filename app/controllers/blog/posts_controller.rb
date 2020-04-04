class Blog::PostsController < ApplicationController
  layout 'blog'
  before_action :set_post, only: [:show]
  before_action :related_posts, only: [:show]
  before_action do
    contentful_layout('Blog Standard Layout')
  end
  before_action :all_tags
  before_action :highlighted_posts
  before_action :categorized_posts

  # GET /posts
  # GET /posts.json
  def index
    # iterate over all content because contentful restriction.
    # only search on references on fields which link to a single entry.
    # Fields which hold references to many entries or fields with references to assets are not supported.
    # See https://www.contentful.com/developers/docs/references/content-delivery-api/#/reference/localization
    # TODO Refator method retriving local data instead of contentful data
    if params.has_key? :tag
      posts = contentful.entries(content_type: 'blogPost', include: 2)
      posts_with_tag = []
      posts.each do |post|
        post.tags.each do |tag|
          if tag.tag == params[:tag]
            posts_with_tag << post
            break
          end
        end
        @contentful_posts =  posts_with_tag
      end
    elsif params.has_key? :category
      posts = contentful.entries(content_type: 'blogPost', include: 2)
      posts_with_category = []
      posts.each do |post|
        if post.category.name == params[:category]
          posts_with_category << post
        end
        @contentful_posts = posts_with_category
      end
    else
      @contentful_posts = contentful.entries(content_type: 'blogPost', include: 2)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post_in_local_db.increment_views
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post_in_local_db = Blog::Post.find_by!(slug: params[:slug])
      @contentful_post = contentful.entries('sys.id' => @post_in_local_db.contentful_id).first
    end

    def contentful_layout(layout)
      @contentful_layout = contentful.entries('content_type' => 'blogLayout', 'include' => 4, 'fields.name' => layout)
    end

    def all_tags
      @all_post_tags = contentful.entries(content_type: 'postTag', include: 2)
    end

    def highlighted_posts
      entries = contentful.entries(content_type: 'highlightedPosts', include: 2)
      @highlighted_posts = entries[0].posts
    end

    # TODO Order by popularity (higher view counts)
    def related_posts
      referenced_post_tags = Blog::Post.find_by(slug: params[:slug]).tags
      tags_id_array = []
      referenced_post_tags.each { |tag| tags_id_array << tag.id }
      @related_posts = Blog::Post.joins(:tags).distinct.where(posts_tags: { tag_id: tags_id_array }).limit(3)
    end

    def categorized_posts
      results = ActiveRecord::Base.connection.exec_query('SELECT c.name, count(p.id)
                                                        FROM categories c, posts p
                                                        WHERE c.id = p.category_id
                                                        GROUP BY c.name')
      @categorized_posts = []
      results.each { |result| @categorized_posts << result }
    end
end
