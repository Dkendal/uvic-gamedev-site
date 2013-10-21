String::lpad = (padding) ->
  zeroes = "0"
  zeroes += "0" for i in [1..padding]
  (zeroes + @).slice(padding * -1)

times = []
for hr in [1..24]
  for mi in [0...12]
    mi_str = String(mi * 5).lpad(2)
    times.push "#{hr}:#{mi_str}"
$ ->
  $('[data-behavior~=timepicker]').typeahead {
    name: 'time',
    local: times
  }


