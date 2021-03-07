# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module ContentHelper
  def html_number(number, options = {})
    default_options = {
      unit: nil,
      precision: 0,
      delimiter: ?\u{2009},
      separator: ','
    }
    options.reverse_merge! default_options

    if number.present?
      number = number_with_precision(number, precision: options[:precision], delimiter: options[:delimiter], separator: options[:separator])

      number = "#{ number } #{ I18n.t(options[:unit], scope: [:units, :html]) }" if options[:unit].present?
      number.html_safe
    end
  end

  def html_boolean(boolean, options = {})
    if boolean
      content_tag :i, nil, class: 'far fa-check-square text-success'
    else
      content_tag :i, nil, class: 'far fa-square'
    end
  end

  def format_datetime(data, options = {})
    default_options = {
      format: :default,
      accumulate_on: :days
    }
    options.reverse_merge! default_options

    data = case data
    when String
      data.try(:to_datetime)
    else
      data
    end

    if data.present?
      case options[:format]
      when :distance
        distance_of_time_in_words Time.zone.now, data, true, highest_measures: 3, accumulate_on: options[:accumulate_on]
      else
        I18n.l data, format: options[:format]
      end
    end
  end

  def download_xlsx_link_to(collection_or_object)
    path = collection_or_object.try(:klass) || collection_or_object
    data = if @pagy.try(:count).try(:>, 10000) or
      (collection_or_object.try(:klass) == CheckMantenimiento and @pagy.try(:count).try(:>, 1000))
      {
        title: t(:download, scope: [:admin_helper, :actions], type: 'XLSX'),
        confirm: t(:download_xlsx, scope: [:admin_helper, :confirmations]),
        'title-icon': 'fas fa-file-download',
        'title-icon-class': 'text-primary',
        'commit-class': 'btn-sm btn-success'
      }
    end

    content_tag :div, class: 'dowload-link-container' do
      link_to polymorphic_path(path, filterrific: @filterrific.to_hash, format: :xlsx), class: 'download-link', data: data do
        capture do
          concat icon 'fas', 'file-download'
          concat content_tag :span, t(:download, scope: [:admin_helper, :actions], type: 'XLSX')
        end
      end
    end
  end

  def link_to_action(action, object, options = {})
    default_options = {
      html_class: nil,
      link_content: nil,
      path: nil
    }
    options.reverse_merge! default_options

    method_name = nil
    confirm_text = nil
    type = nil
    turbolinks = nil
    path = options[:path]

    case action
    when :show
      path ||= object
      icon_options = 'far', 'eye'

    when :new
      path ||= [:new, object.model_name.singular_route_key]
      icon_options = 'fas', 'plus'
      turbolinks = false

    when :edit
      path ||= [:edit, object]
      icon_options = 'far', 'edit'
      turbolinks = false

    when :destroy
      path ||= object
      method_name = :delete
      confirm_text = t :destroy, scope: [:admin_helper, :confirmations], model: object.singularize
      icon_options = 'far', 'trash-alt'

    when :next
      path ||= object.next
      icon_options = 'fas', 'angle-right'
      return if path.nil?

    when :prev
      path ||= object.prev
      icon_options = 'fas', 'angle-left'
      return if path.nil?
    end

    link_to path, class: options[:html_class], method: method_name, data: { toggle: 'tooltip', placement: 'bottom', title: t(action, scope: [:admin_helper, :actions], model: object.singularize, type: type), confirm: confirm_text, turbolinks: turbolinks } do
      options[:link_content].present? ? "#{ icon(*icon_options) } #{ content_tag :span, options[:link_content] }".html_safe : icon(*icon_options)
    end
  end

  def actions_generator(object)
    content_tag :div, class: 'content-center table-nowrap' do
      concat link_to_action(:show, object)
      concat link_to_action(:edit, object, html_class: 'text-warning')
      concat link_to_action(:destroy, object, html_class: 'text-danger')
    end
  end

  def modal_helper(options = {}, &block)
    default_options = {
      id: nil,
      link_content: nil,
      link_class: nil,
      modal_class: 'modal fade',
      modal_dialog_class: 'modal-dialog modal-dialog-centered',
      modal_content: true,
      backdrop: true,
      data: { toggle: 'modal', target: "##{ options[:id] }" }
    }
    options.reverse_merge! default_options

    capture do
      concat link_to '#', class: options[:link_class], data: options[:data], &-> do
        options[:link_content]
      end
      concat content_tag :div, id: options[:id], class: options[:modal_class], tabindex: -1, role: 'dialog', data: { backdrop: options[:backdrop] }, &-> do
        content_tag :div, class: options[:modal_dialog_class] do
          if options[:modal_content]
            content_tag :div, class: 'modal-content' do
              content_tag :div, class: 'modal-body' do
                capture(&block)
              end
            end
          else
            content_tag :div, class: 'modal-body' do
              capture(&block)
            end
          end
        end
      end
    end
  end

  def link_to_add_association_wrapper(form, association = nil, options = {})
    default_options = {
      class: 'btn btn-sm'
    }
    options.reverse_merge! default_options

    collection = (options.delete(:collection) || association.model_name.collection.gsub(?/, ?_))

    content_tag :div, class: 'links col-12', id: 'add-object' do
      link_to_add_association form, collection, options do
        concat content_tag :span, &-> do
          t :add, scope: [:admin_helper, :actions], model: association.singularize
        end
        concat icon 'fas', 'plus'
      end
    end
  end

  def link_to_remove_association_wrapper(form, options = {})
    default_options = {
      class: 'btn btn-sm',
      data: {
        toggle: 'tooltip',
        placement: 'bottom',
        title: t(:destroy, scope: [:admin_helper, :actions], model: form.object.singularize),
        confirm: t(:destroy, scope: [:admin_helper, :confirmations], model: form.object.singularize)
      }
    }
    options.reverse_merge! default_options

    content_tag :div, class: 'links col-12', id: 'destroy-object' do
      link_to_remove_association form, options do
        icon 'far', 'trash-alt'
      end
    end
  end
end
