class Blog::BlogPagesController < ApplicationController
  layout 'blog'
  before_action do
    contentful_layout('Blog Standard Layout')
  end
  before_action :set_page, only: [:show]
  before_action :all_tags
  before_action :highlighted_posts
  before_action :categorized_posts

  # GET /blog_pages/1
  # GET /blog_pages/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Blog::BlogPage.find_by(slug: params[:slug])
    end
    # TODO DRY method - repeated on PostsController
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

    def categorized_posts
      results = ActiveRecord::Base.connection.exec_query('SELECT c.name, count(p.id)
                                                          FROM categories c, posts p
                                                          WHERE c.id = p.category_id
                                                          GROUP BY c.name')
      @categorized_posts = []
      results.each { |result| @categorized_posts << result }
    end
end
