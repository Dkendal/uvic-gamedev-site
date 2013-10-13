$ ->
  $dp = $('[data-behavior~=datepicker]')
  $dp.datepicker()

  $dp.each ->
    $(@).siblings('.input-group-addon').click =>
      this.focus()


