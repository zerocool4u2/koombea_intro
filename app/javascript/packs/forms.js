document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip();

  $.fn.datetimepicker.Constructor.Default = $.extend({}, $.fn.datetimepicker.Constructor.Default, {
    icons: {
      time: 'far fa-clock',
      date: 'far fa-calendar-alt',
      up: 'fas fa-arrow-up',
      down: 'fas fa-arrow-down',
      previous: 'fas fa-chevron-left',
      next: 'fas fa-chevron-right',
      today: 'far fa-calendar-check',
      clear: 'far fa-trash-alt',
      close: 'fas fa-times'
    },
    tooltips: {
      today: 'Seleccionar Fecha y Hora Actual',
      clear: 'Limpiar selección',
      close: 'Cerrar el Picker',
      selectMonth: 'Seleccionar Mes',
      prevMonth: 'Mes Anterior',
      nextMonth: 'Mes Siguiente',
      selectYear: 'Seleccionar Año',
      prevYear: 'Año Anterior',
      nextYear: 'Año Siguiente',
      selectDecade: 'Seleccionar Década',
      prevDecade: 'Década Anterior',
      nextDecade: 'Década Siguiente',
      prevCentury: 'Siglo Anterior',
      nextCentury: 'Siglo Siguiente',
      pickHour: 'Seleccionar Hora',
      incrementHour: 'Incrementar Hora',
      decrementHour: 'Decrementar Hora',
      pickMinute: 'Seleccionar Minuto',
      incrementMinute: 'Incrementar Minuto',
      decrementMinute: 'Decrementar Minuto',
      pickSecond: 'Seleccionar Segundo',
      incrementSecond: 'Incrementar Segundo',
      decrementSecond: 'Decrementar Segundo',
      togglePeriod: 'Toggle Periodo',
      selectTime: 'Seleccionar Hora',
      selectDate: 'Seleccionar Fecha'
    },
    buttons: {
      showToday: true,
      showClear: false,
      showClose: false
    }
  });

  var init_date_time_picker, init_velocidad_promedio_calc;
    $('.form-container').on('cocoon:after-insert', function() {
      show_or_hide_add_links();
      init_date_time_picker();
      init_chosen_select();
      return init_velocidad_promedio_calc();
    });
    $('.form-container').on('cocoon:after-remove', function() {
      return show_or_hide_add_links();
    });
    $('.custom-file-input').on('change', function() {
      return $(this).parent().find('label').text($(this).val().split('\\').pop());
    });
    init_date_time_picker = function() {
      $('.datetimepicker-input').each(function(index) {
        $(this).parent('.input-group').attr("id", "datetimepicker" + index);
        $(this).attr("data-target", "#datetimepicker" + index);
        return $(this).next('.input-group-append').attr("data-target", "#datetimepicker" + index);
      });
      init_tooltip();
      $('.date-picker-only').datetimepicker({
        format: 'L'
      });
      return $('.time-picker-only').datetimepicker({
        format: 'HH:mm'
      });
    };
    window.init_chosen_select = function() {
      return $('.chosen-select').chosen({
        allow_single_deselect: true,
        no_results_text: 'Sin resultados',
        placeholder_text_single: 'No selecionado',
        placeholder_text_multiple: 'No selecionado',
        width: '100%',
        disable_search_threshold: 5
      });
    };
    init_velocidad_promedio_calc = function() {
      return $('.desplazamiento_mm').on('change paste keyup', function() {
        var divider, value, velocidad_promedio_mm_h;
        value = $(this).val();
        if (isFinite(value)) {
          velocidad_promedio_mm_h = $(this).parents('.velocidad_promedio_calc').find('.velocidad_promedio_mm_h');
          divider = velocidad_promedio_mm_h.data('divider') || 12;
          return velocidad_promedio_mm_h.val((value / divider).toFixed(2));
        }
      });
    };
    init_date_time_picker();
    init_chosen_select();
    init_velocidad_promedio_calc();
  });
})
