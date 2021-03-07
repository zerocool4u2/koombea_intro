# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module SimpleForm
  module CoreExtensions
    module Inputs
      # ### It'll infere if use a prompt(mobile version) or use a data-placeholder for chosen(desktop version)
      #
      # ### Requeriments:
      #
      # ### 1. simple_form.rb initializer
      #
      #   config.wrapper_mappings = {
      #     select: :chosen_select,
      #     grouped_select: :chosen_select
      #   }
      #   # or manually select them
      #
      #
      # ### 2. simple_form.rb initializer wrappers
      #
      #   config.wrappers :chosen_select, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
      #     ...
      #   end
      #   # or
      #   config.wrappers :chosen_select_inline, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
      #     ...
      #   end
      #
      # ### 3. Have the corresponding translation
      #
      #   t('admin_helper.filterrific.select', attribute: 'my_attribute')
      #
      # ### 4. simple_form_for inputs, pass a :placeholder option to the input
      #
      #   = f.input :type, collection: Type.all, placeholder: Type.model_name.human
      module ChosenPlaceholder
        def initialize(builder, attribute_name, column, input_type, options = {})
          super

          if inline_form? and not mobile?
            @input_html_options = html_options_for(:input, input_html_classes).tap do |o|
              o.deep_merge! data: { placeholder: options[:placeholder] }
            end
          end
        end

        def input_options
          options = super

          if inline_form? and mobile?
            options[:include_blank] = false
            options[:prompt] = t(:select, scope: [:admin_helper, :filterrific], attribute: options[:placeholder])
          end

          options[:include_blank] = true unless skip_include_blank?
          translate_option options, :prompt
          translate_option options, :include_blank

          options
        end

        def mobile?
          template.request.user_agent =~ /Mobile|(tablet|ipad)|(android(?!.*mobile))/i
        end

        def inline_form?
          return unless options[:placeholder] # return if empty

          if select = @builder.options.dig(:wrapper_mappings, :select)
            select == :chosen_select_inline
          elsif grouped_select = @builder.options.dig(:wrapper_mappings, :grouped_select)
            grouped_select == :chosen_select_inline
          else
            false
          end
        end
      end
    end
  end
end
SimpleForm::Inputs::CollectionInput.prepend SimpleForm::CoreExtensions::Inputs::ChosenPlaceholder
