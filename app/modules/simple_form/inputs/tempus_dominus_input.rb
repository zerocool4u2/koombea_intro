# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

class TempusDominusInput < SimpleForm::Inputs::Base
  def input(wrapper_options)

    @input_html_options = html_options_for(:input, input_html_classes).tap do |o|
      o[:readonly]  = true if has_readonly?
      o[:disabled]  = true if has_disabled?
      o[:autofocus] = true if has_autofocus?
      o[:value] = input_formatted_value
    end

    template.content_tag(:div, class: input_group_html_classes, data: { target_input: 'nearest' }) do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat template.content_tag :div, class: 'input-group-append', data: { toggle: 'datetimepicker' }, &-> do
        template.content_tag :span, class: 'input-group-text' do
          input_group_html_icon
        end
      end
    end
  end

  def input_html_classes
    'form-control datetimepicker-input '
  end

  def input_group_html_classes
    case options[:type]
    when :only_time
      'input-group time-picker-only'
    when :only_date
      'input-group date-picker-only'
    else
      'input-group'
    end
  end

  def input_group_html_icon
    options[:icon] ||= case options[:type]
    when :only_time
      'clock'
    else
      'calendar-alt'
    end

    "<i class='far fa-#{ options[:icon] }'></i>".html_safe
  end

  def input_formatted_value
    return nil if object.nil? or not object.respond_to? attribute_name

    case options[:type]
    when :only_time
      template.format_datetime object.public_send(attribute_name).try(:to_datetime), format: :only_time
    when :only_date
      template.format_datetime object.public_send(attribute_name).try(:to_date)
    else
      template.format_datetime object.public_send(attribute_name)
    end
  end
end
