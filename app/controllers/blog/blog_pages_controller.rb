# frozen_string_literal: true
class Blog::BlogPagesController < ApplicationController
  before_action do
    layout_data("Blog Standard Layout")
  end
  before_action :set_page, only: [:show]
  before_action :all_tags
  before_action :highlighted_posts
  before_action :categorized_posts

  # GET /blog_pages/1
  # GET /blog_pages/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Blog::BlogPage.find_by(slug: params[:slug])
  end
end
