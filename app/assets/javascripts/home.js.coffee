$ ->
  $events = $ '[data-load="events"]'
  if $events.length > 0
    event_xhr = $.get '/events'

    event_xhr.done (data) ->
      $events.replaceWith(data)

    event_xhr.fail (data) ->
      alert data.responseText
