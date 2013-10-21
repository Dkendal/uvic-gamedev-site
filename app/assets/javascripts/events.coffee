toggle_datetime_picker = ($datepicker, $timepicker) ->
    $timepicker.col_wrapper.toggleClass('col-sm-3').toggleClass('col-sm-6')
    $datepicker.col_wrapper.toggleClass('col-sm-9').toggleClass('col-sm-6')

$ ->
  $dp = $('[data-behavior~=datepicker]')
  $dp.datepicker(
    format: 'yyyy/mm/dd'
  )

  # focus input when calendar add-on clicked
  $dp.each ->
    $(@).siblings('.input-group-addon').click =>
      this.focus()

  # animate 'Has end?' button
  $('#event_has_end').click ->
    $wrapper = $(@).closest('.form-group')
    $wrapper.slideUp ->
      $wrapper.addClass 'hidden'
      $wrapper.show()
      $end_row = $('#event_end_date').closest('.hidden')
      $end_row.hide()
      $end_row.removeClass 'hidden'
      $end_row.slideDown()

  # animate date and time pickers sliding in and out
  # slide out when time picker focus, shrink when
  # time picker looses focus and has no text
  $('.datetime-picker').each ->
    $datepicker = $(@).find '[data-behavior="datepicker"]'
    $timepicker = $(@).find '[data-behavior="timepicker"]'

    $datepicker.col_wrapper = $datepicker.closest('.col-sm-9')
    $timepicker.col_wrapper = $timepicker.closest('.col-sm-3')

    $timepicker.focus ->
      if $timepicker.col_wrapper.hasClass 'col-sm-3'
        @.original_placeholder ?= @.placeholder
        @.placeholder = 'hh:mm'
        toggle_datetime_picker $datepicker, $timepicker

    $timepicker.blur ->
      unless @.value
        @.placeholder = @.original_placeholder
        toggle_datetime_picker $datepicker, $timepicker

  # swap placeholder text of datepicker on focus/blur
  $datepickers = $('[data-behavior="datepicker"]')

  $datepickers.focus ->
    @.original_placeholder ?= @.placeholder
    @.placeholder = 'yyyy/mm/dd'

  $datepickers.blur ->
    @.placeholder = @.original_placeholder

