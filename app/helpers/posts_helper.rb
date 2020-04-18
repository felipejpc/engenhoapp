# frozen_string_literal: true

module PostsHelper
  require 'rich_text_renderer'

  def rich_text_render(content)
    renderer = RichTextRenderer::Renderer.new
    renderer.render(content)
  end
end
