# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module SimpleForm
  module CoreExtensions
    module FormBuilder
      module Submit
        def submit_button(action, options = {}, &block)
          default_options = {
            wrapper_class: 'col-12 form-action'
          }
          options.reverse_merge! default_options

          ActionController::Base.helpers.content_tag(:div, class: options[:wrapper_class]) do
            options.delete(:wrapper_class) if options[:wrapper_class]
            submit(action, options, &block)
          end
        end
      end
    end
  end
end
SimpleForm::FormBuilder.prepend SimpleForm::CoreExtensions::FormBuilder::Submit
