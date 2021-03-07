# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

module ApplicationHelper
  include Pagy::Frontend

  def title(content = nil)
    content_for :title do
      if content.present?
        "#{ content } | #{ t 'defaults.app_name' }"
      elsif t('.title', default: '').present?
        "#{ t '.title' } | #{ t 'defaults.app_name' }"
      else
        t 'defaults.app_name'
      end
    end
  end

  def display_alert(content_or_options_with_block = {}, options = {}, &block)
    if block_given?
      options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
      message = capture(&block)
    else
      return if sanitize(content_or_options_with_block, tags: %w()).blank?
      message = content_tag :p, sanitize(content_or_options_with_block, tags: %w())
    end

    default_options = {
      class: 'alert-success'
    }
    options.reverse_merge! default_options

    options[:class] = (%w(alert alert-dismissible fade show) << options[:class]).sort.join(' ')

    if message.present?
      content_tag :div, class: options[:class] do
        capture do
          concat content_tag :button, class: 'close', data: { dismiss: 'alert' }, &-> do
            icon 'fas', 'times'
          end
          concat message
        end
      end
    end
  end

  def sidebar_link_to(path, options = {}, &block)
    default_options = {
      action_name: :index
    }
    options.reverse_merge! default_options

    if block_given?
      return if capture(&block).blank?

      capture do
        concat content_tag :li, class: 'nav-item', &-> do
          link_to path, class: 'nav-link collapsed sidebar-button', data: { toggle: 'collapse' } do
            concat icon 'fas', options[:icon]
            concat content_tag :span, options[:text], class: 'sidebar-text'
            concat icon 'fas chevron', 'chevron-down'
          end
        end
        concat content_tag :ul, class: 'nav collapse page-submenu', id: path.gsub(?#, ''), &-> do
          capture(&block)
        end
      end
    else
      content_tag :li, class: 'nav-item' do
        if current_page?(path)
          content_tag :span, class: 'nav-link active' do
            concat icon 'fas', options[:icon] if options[:icon].present?
            concat content_tag :span, options[:text], class: 'sidebar-text'
            concat icon 'fas chevron', 'chevron-right'
          end
        else
          link_to path, class: 'nav-link' do
            concat icon 'fas', options[:icon] if options[:icon].present?
            concat content_tag :span, options[:text], class: 'sidebar-text'
            concat icon 'fas chevron', 'chevron-right'
          end
        end
      end
    end
  end
end
