class PostsController < ApplicationController
  layout 'blog'
  before_action :set_post, only: [:show]
  # before_action :related_posts, only: [:show]
  before_action do
    contentful_layout('Blog Standard Layout')
  end
  before_action :all_tags
  before_action :highlighted_posts

  # GET /posts
  # GET /posts.json
  def index
    # iterate over all content because contentful restriction.
    # only search on references on fields which link to a single entry.
    # Fields which hold references to many entries or fields with references to assets are not supported.
    # See https://www.contentful.com/developers/docs/references/content-delivery-api/#/reference/localization
    if params[:tag].present?
      posts = contentful.entries(content_type: 'blogPost', include: 2)
      posts_with_tag = []
      posts.each do |post|
        post.tags.each do |tag|
          if tag.tag == params[:tag]
            posts_with_tag << post
            break
          end
        end
      end
      @contentful_posts = posts_with_tag
    else
      @contentful_posts = contentful.entries(content_type: 'blogPost', include: 2)
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      post_in_local_db = Post.find_by!(slug: params[:slug])
      @contentful_post = contentful.entries('sys.id' => post_in_local_db.content_id).first
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

    # def related_posts
    #   # @related_posts =
    #   tags = []
    #   @contentful_post.tags.each do |tag|
    #     tags << tag.tag
    #   end
    #   binding.pry
    #
    #   posts = contentful.entries(content_type: 'blogPost', include: 2)
    #   posts_with_tags = []
    #   posts.each do |post|
    #     post.tags.each do |tag|
    #       if tag.tag == params[:tag]
    #         posts_with_tags << post
    #         break
    #       end
    #     end
    #   end
    # end
end
