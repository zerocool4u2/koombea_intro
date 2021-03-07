# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module HeaderHelper
  class Context
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
    include Rails.application.routes.url_helpers

    attr_accessor :context, :output_buffer, :controller, :title

    def initialize(context, title = nil)
      @context, @title, @output_buffer = context, title, ActiveSupport::SafeBuffer.new
    end

    def breadcrumbs(html_class = 'breadcrumb hidden-xs', &block)
      context = Context.new self

      if block_given?
        capture { block.call context }
      end

      context.breadcrumb(@title)

      @output_buffer << content_tag(:ol, class: html_class) do
        context.output_buffer
      end
    end

    def breadcrumb(text, path = nil, options = {})
      default_options = {
        html_class: 'breadcrumb-item',
        icon: nil
      }
      options.reverse_merge! default_options

      text = "#{ options[:icon] } #{ text }".html_safe if options[:icon].present?

      @output_buffer << if path.present?
        content_tag :li, class: options[:html_class] do
          link_to text, path
        end
      else
        content_tag :li, class: "#{ options[:html_class] } active" do
          content_tag :span, text
        end
      end
    end

    def buttons(html_class = 'buttons', &block)
      @output_buffer << content_tag(:div, @context.capture(&block), class: html_class)
    end
  end

  def header(title_text = nil, options = {}, &block)
    default_options = {
      create_title: true,
      heading_size: :h1,
      header_class: 'header-content',
      links_container_class: 'links-container'
    }
    options.reverse_merge! default_options

    title_text = title_text.present? ? title_text.to_s : t('.title')

    if block_given?
      context = Context.new self, title_text

      capture { block.call context }
    end

    title title_text if options[:create_title]

    content_tag :header, class: options[:header_class] do
      capture do
        concat content_tag options[:heading_size], &-> do
          title_text
        end
        if block_given?
          concat content_tag :div, class: options[:links_container_class], &-> do
            context.output_buffer
          end
        end
      end
    end
  end
end
