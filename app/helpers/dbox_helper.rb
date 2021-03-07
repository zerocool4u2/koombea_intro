# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module DboxHelper
  class Context
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::NumberHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::UrlHelper
    include Rails.application.routes.url_helpers
    include ContentHelper

    attr_accessor :context, :object, :output_buffer, :controller

    def initialize(context, object)
      @context, @object = context, object
    end

    def content(attribute_name, options = {})
      default_options = {
        object: @object,
        label: nil,
        content: nil,
        simple_format: false
      }
      options.reverse_merge! default_options

      capture do
        concat content_tag :dt, &-> do
          options[:label] || options[:object].attribute_name(attribute_name).html_safe
        end
        concat content_tag :dd, &-> do
          content = if options[:content].present?
            options[:content].to_s
          else
            options[:object].public_send(attribute_name).to_s
          end
          options[:simple_format] ? simple_format(content) : content
        end
      end
    end

    def datetime(attribute_name, options = {})
      default_options = {
        object: @object
      }
      options.reverse_merge! default_options

      content attribute_name, content: format_datetime(options[:object].public_send(attribute_name), options), label: options[:label], object: options[:object]
    end

    def number(attribute_name, options = {})
      default_options = {
        object: @object
      }
      options.reverse_merge! default_options

      content attribute_name, content: html_number(options[:object].public_send(attribute_name), options), label: options[:label], object: options[:object]
    end

    def image(attribute_name, options = {})
      default_options = {
        object: @object
      }
      options.reverse_merge! default_options

      content attribute_name, content: image_preview(options[:object], attribute_name, options)
    end

    def list(attribute_name, options = {})
      default_options = {
        object: @object,
        collection: nil,
        heading: true,
        tag: :div,
        tag_item: nil,
        tag_class: 'row',
        tag_item_class: 'col-12',
        span_class: nil
      }
      options.reverse_merge! default_options

      options[:collection] ||= options[:object].public_send(attribute_name)

      options[:tag_item] ||= options[:tag] == :ul ? :li : :div

      capture do
        if options[:heading]
          concat content_tag :dt, &-> do
            options[:object].attribute_name(attribute_name).html_safe
          end
        end
        concat content_tag :dd, &-> do
          content_tag options[:tag], class: options[:tag_class] do
            options[:collection].each do |i|
              concat content_tag options[:tag_item], class: options[:tag_item_class], &-> do
                content_tag :span, i, class: options[:span_class]
              end
            end
          end
        end
      end
    end

    def boolean(attribute_name, options = {})
      default_options = {
        object: @object,
        heading: false
      }

      options.reverse_merge! default_options

      capture do
        if options[:heading]
          concat content_tag :dt, &-> do
            options[:object].attribute_name(attribute_name).html_safe
          end
        end
        concat content_tag :dd, class: 'checkbox', &-> do
          concat html_boolean(options[:object].public_send(attribute_name))
          concat options[:object].attribute_name(attribute_name).html_safe
        end
      end
    end
  end

  def dbox_for(object, options = {}, &block)
    default_options = {
      class: 'display-box-container'
    }

    options.reverse_merge! default_options

    context = Context.new self, object

    content_tag :dl, class: options[:class] do
      capture(context, &block)
    end
  end
end
