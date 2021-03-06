# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.error_notification_tag = nil
  config.error_notification_class = nil
  config.error_method = :to_sentence
  config.button_class = 'btn'
  config.boolean_label_class = 'form-check-label'
  config.boolean_style = :inline
  config.form_class = 'form-container'
  config.i18n_scope = 'activerecord.attributes'
  config.translate_labels = true
  config.browser_validations = false
  config.generate_additional_classes_for = []

  config.default_wrapper = :vertical_form
  config.wrapper_mappings = {
    boolean: :vertical_boolean,
    select: :chosen_select,
    grouped_select: :chosen_select,
    file: :custom_file_input,
    check_boxes: :vertical_radio_and_checkboxes,
    radio_buttons: :vertical_radio_and_checkboxes,
    datetime: :vertical_form,
    date: :multi_select,
    time: :multi_select,
    image: :image_input
  }

  config.wrappers :vertical_form, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.use :maxlength
    b.optional :pattern
    b.use :min_max
    b.optional :readonly
    b.use :label

    b.use :input, class: 'form-control'
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :vertical_boolean, tag: :div, class: 'form-check', error_class: 'has-danger' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'form-check-input'
    b.use :label, class: 'form-check-label'

    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :custom_checkbox_switch, tag: :div, class: 'form-check custom-control custom-switch', error_class: 'has-danger' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'custom-control-input'
    b.use :label, class: 'custom-control-label'

    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :horizontal_form, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-2 col-form-label'

    b.wrapper tag: :div, class: 'col-sm-10' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
      ba.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
    end
  end

  config.wrappers :horizontal_file_input, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label, class: 'col-sm-2 col-form-label'

    b.wrapper tag: :div, class: 'col-sm-10' do |ba|
      ba.use :input, class: 'form-control-file'
      ba.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
      ba.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
    end
  end

  config.wrappers :horizontal_radio_and_checkboxes, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.optional :readonly

    b.use :label, class: 'col-sm-2 col-form-label'

    b.wrapper tag: :div, class: 'col-sm-10' do |ba|
      ba.use :input, class: 'form-check-input'
      ba.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
      ba.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
    end
  end

  config.wrappers :vertical_file_input, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label

    b.use :input, class: 'form-control-file'
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :custom_file_input, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label

    b.wrapper tag: :div, class: 'custom-file' do |ba|
      ba.use :input, class: 'custom-file-input'
      ba.wrapper tag: :label, class: 'custom-file-label' do |bb|
      end
    end
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
    b.use :preview
  end

  config.wrappers :image_input, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :readonly
    b.use :label
    b.use :signed_id
    b.use :pasteable

    b.use :input
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
    b.use :preview
  end

  config.wrappers :vertical_radio_and_checkboxes, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'form-check-label'
    b.use :input, class: 'form-check-input'
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :inline_form, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :input, class: 'form-control'
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :multi_select, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-2 col-form-label'
    b.wrapper tag: :div, class: 'col-sm-10' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
      ba.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
    end
  end

  config.wrappers :input_with_placeholder, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input, class: 'form-control'
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :single_line_nested_item, tag: :div, class: 'form-group row', error_class: 'has-danger' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-2 col-form-label'

    b.wrapper tag: :div, class: 'col-10 col-sm-8' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
      ba.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
    end

    b.wrapper tag: :div, class: 'col-2 col-sm-1' do |ba|
      ba.use :remove_link
    end
  end

  config.wrappers :chosen_select, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label

    b.use :input, class: 'form-control chosen-select'
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :chosen_select_inline, tag: :div, class: 'form-group', error_class: 'has-danger' do |b|
    b.use :html5
    b.optional :readonly

    b.use :input, class: 'form-control chosen-select'
    b.use :error, wrap_with: { tag: :div, class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: :small, class: 'form-text text-muted' }
  end

  config.wrappers :check_buttons, tag: :div, class: 'btn-group' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper tag: :label, class: 'btn btn-outline-primary' do |ba|
      ba.use :input
      ba.use :label_text
    end
  end
end
