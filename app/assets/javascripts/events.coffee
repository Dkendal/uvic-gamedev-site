$ ->
  $dp = $('[data-behavior~=datepicker]')
  $dp.datepicker()
  focus_bound = ->
    unless $(this).is(':focus')
      this.focus()

  $dp.each ->
    $(@).siblings('.input-group-addon').click focus_bound.bind(@)


