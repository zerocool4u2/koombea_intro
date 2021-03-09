# Copyright (c) 2020 Alexis Ramis.
# All Rights Reserved

module PagyHelper
  def render_list(collection_class = controller_name.classify.constantize)
    # AJAX call
    <<~JsERB.gsub(/\s+/, ' ').strip # clean up spaces
      $('#results').html('<%= j render partial: "#{ collection_class.model_name.route_key }/list" %>');
    JsERB
  end

  def paginate_with_info
    capture do
      concat paginate_links
      concat paginate_info
    end
  end

  def paginate_links
    return if @pagy.pages <= 1

    link = pagy_link_proc(@pagy, 'class="page-link"')

    content_tag :nav, role: 'navigation', aria: { label: 'pager' }, &-> do
      content_tag :ul, class: 'pagination pagination-sm justify-content-center' do
        if @pagy.page > 1 + @pagy.vars[:size][1] + 1
          concat content_tag :li, class: 'page-item', &-> do
            link.call(1, pagy_t('pagy.nav.first'), 'aria-label="first"').html_safe
          end
        end

        if @pagy.prev
          concat content_tag :li, class: 'page-item', &-> do
            link.call(@pagy.prev, pagy_t('pagy.nav.prev'), 'aria-label="previous"').html_safe
          end
        end

        @pagy.series.each do |item|
          if item.is_a? Integer
            concat content_tag :li, class: 'page-item', &-> do
              link.call(item).html_safe
            end
          elsif item.is_a? String
            concat content_tag :li, class: 'page-item active', &-> do
              content_tag :span, item, class: 'page-link'
            end
          end
        end

        if @pagy.next
          concat content_tag :li, class: 'page-item', &-> do
            link.call(@pagy.next, pagy_t('pagy.nav.next'), 'aria-label="next"').html_safe
          end
        end

        if @pagy.page < @pagy.last - @pagy.vars[:size][2] - 1
          concat content_tag :li, class: 'page-item', &-> do
            link.call(@pagy.last, pagy_t('pagy.nav.last'), 'aria-label="last"').html_safe
          end
        end
      end
    end
  end

  def paginate_info
    content_tag :h6, class: 'small text-muted text-center' do
      pagy_info(@pagy).html_safe
    end
  end
end
