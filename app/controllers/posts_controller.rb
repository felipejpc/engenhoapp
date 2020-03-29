class PostsController < ApplicationController
  layout 'blog'
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action do
    contentful_layout('Blog Standard Layout')
  end
  before_action :all_tags

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

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by!(slug: params[:slug])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title)
    end

    def contentful_layout(layout)
      @contentful_layout = contentful.entries('content_type' => 'blogLayout', 'include' => 4, 'fields.name' => layout)
    end

    def all_tags
      @all_post_tags = contentful.entries(content_type: 'postTag', include: 2)
    end
end
