# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module FlashHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Context

  def flash_message_for(object, action, request_method: :itself, type: :notice, gender: :male)
    flash.public_send(request_method)[type] = content_tag :div do
      concat content_tag :p, &-> do
        concat I18n.t gender, scope: [:flash_messages, :actions, action, type], resource_name: object.class.model_name.human
        concat I18n.t :problems, scope: [:flash_messages, :actions], count: object.errors.count unless type == :notice
      end
      concat content_tag :ul, &-> do
        object.errors.full_messages.each do |message|
          concat content_tag :li, &-> do
            message.sub(/^./, &:capitalize).html_safe
          end
        end
      end
    end
  end
end
