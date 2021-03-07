# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module TableHelper
  class Context
    include ActionView::Helpers::TextHelper
    include ContentHelper

    attr_accessor :context, :objects, :output_buffer, :columns_buffer, :header_buffer, :footer_buffer

    def initialize(context, objects)
      @context, @objects, @output_buffer, @columns_buffer = context, objects, ActiveSupport::SafeBuffer.new, Hash.new
    end

    def generate_table(options = {})
      @output_buffer << @header_buffer
      @output_buffer << content_tag(:table, class: options[:class]) do
        capture do
          concat content_tag :thead, class: options[:thead_class], &-> do
            content_tag :tr do
              generate_thead
            end
          end
          concat content_tag :tbody, class: options[:tbody_class], &-> do
            generate_tbody
          end
        end
      end
      @output_buffer << @footer_buffer
    end

    def generate_thead
      default_options = {
        th_class: 'table-center'
      }

      @columns_buffer.each do |attribute, options|
        options.reverse_merge! default_options

        content = options[:th] || @objects.attribute_name(attribute)

        concat content_tag :th, content, class: options[:th_class]
      end
    end

    def generate_tbody
      default_options = {
        td_class: nil
      }
      capture do
        @objects.each do |object|
          concat content_tag :tr, &-> do
            capture do
              @columns_buffer.each do |attribute, options|
                options.reverse_merge! default_options

                content = options[:td] || object.public_send(attribute)

                if content.is_a? Proc
                  content = content.call object
                end

                if options[:type] == :boolean
                  content = html_boolean(content)
                end

                concat content_tag :td, content, class: options[:td_class]
              end
            end
          end
        end
      end
    end

    def column(attribute, options = {})
      @columns_buffer[attribute] = options
    end

    def header(content)
      @header_buffer = content
    end

    def footer(content)
      @footer_buffer = content
    end
  end

  def table_for(objects, options = {}, &block)
    default_options = {
      class: 'table',
      thead_class: 'thead-dark',
      tbody_class: nil
    }
    options.reverse_merge! default_options

    context = Context.new self, objects

    capture { block.call context }

    context.generate_table options

    context.output_buffer
  end
end
