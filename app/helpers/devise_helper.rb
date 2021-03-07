# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

module DeviseHelper
  def devise_form_for(action, options = {}, &block)
    default_options = {
      as: resource_name,
      url: nil,
      method: :post,
      html: { class: 'devise-form' }
    }
    options.reverse_merge! default_options
    options[:url] ||= public_send("#{ action }_path", options[:as])

    title
    flash_message_for resource, :devise, request_method: :now, type: :error if resource.errors.any?

    content_tag :div, class: 'devise-container' do
      content_tag :div, class: 'card' do
        capture do
          concat content_tag :div, class: 'card-header', &-> do
            link_to new_session_path(resource_name) do
              image_tag 'brand-logo.svg', class: 'brand-logo'
            end
          end
          concat content_tag :div, class: 'card-body', &-> do
            capture do
              concat content_tag :div, class: 'title', &-> do
                capture do
                  concat content_tag :h4, &-> do
                    t '.title'
                  end
                  concat content_tag :h6, &-> do
                    t '.description'
                  end
                end
              end
              concat simple_form_for(resource, options, &block)
            end
          end
        end
      end
    end
  end
end
