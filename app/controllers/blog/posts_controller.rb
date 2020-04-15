# frozen_string_literal: true
class Blog::PostsController < ApplicationController
  before_action :set_post, only: [:show]
  before_action :related_posts, only: [:show]
  #TODO DRY contentful_layout method. Research about rails layout method
  before_action do
    layout_data("Blog Standard Layout")
  end
  before_action :all_tags
  before_action :highlighted_posts
  before_action :categorized_posts

  # GET /posts
  # GET /posts.json
  def index
    # TODO Refator method without ifs
    if params.key? :tag
      @posts = Blog::Post.joins(:tags).where(tags: {tag_name: params[:tag]})
    elsif params.key? :category
      @posts = Blog::Category.find_by(name: params[:category]).posts
    else
      @posts = Blog::Post.all
      binding.pry
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post.increment_views
  end

  # GET /posts-search?q=<google-params-search>
  def search; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Blog::Post.find_by!(slug: params[:slug])
  end
end
