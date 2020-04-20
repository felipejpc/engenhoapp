# frozen_string_literal: true
class ApplicationController < ActionController::Base
  layout :determine_layout
  # TODO Refactor - create instace variable for all contentful linked items
  def layout_data(layout)
    @layout_data = Layout.find_by(name: layout)
    @menu_items = @layout_data.json['custom_json']['fields']['menuItems']
  end

  def all_tags
    @all_post_tags = Blog::Tag.all
  end

  # TODO: delegate to Blog:Post
  def highlighted_posts
    @highlighted_posts = Blog::Post.where(highlighted: true)
  end

  # TODO: Order by popularity (higher view counts)
  def related_posts
    referenced_post_tags = Blog::Post.find_by(slug: params[:slug]).tags
    tags_id_array = []
    referenced_post_tags.each {|tag| tags_id_array << tag.id }
    @related_posts = Blog::Post.joins(:tags).distinct.where(posts_tags: {tag_id: tags_id_array}).limit(3)
  end

  def categorized_posts
    results = ActiveRecord::Base.connection.exec_query('SELECT c.name, count(p.id)
                                                        FROM categories c, posts p
                                                        WHERE c.id = p.category_id
                                                        GROUP BY c.name')
    @categorized_posts = []
    results.each {|result| @categorized_posts << result }
  end

  private

  def determine_layout
    params[:subdomain]
  end
end
