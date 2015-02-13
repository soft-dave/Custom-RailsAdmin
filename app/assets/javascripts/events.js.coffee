$(document).on 'ready rails_admin.dom_ready', ->

  $('#calendar').fullCalendar
    eventSources: [{  
      url: '/events',
    }], 

    editable: true,  
    header:  
      left: 'prev,next today',  
      center: 'title',  
      right: 'month,agendaWeek,agendaDay'

    defaultView: 'month' 
    height: 500 
    eventColor: 'gray'
    eventTextColor: 'black'
    slotMinutes: 30

    dragOpacity: "0.5"  

    eventDrop: (event, delta, revertFunc) -> 
      updateEvent event

    eventResize: (event, delta, revertFunc) ->
      updateEvent event

    eventClick: (event, jsEvent, view) ->
      eventId = event.id
      $('#event_popup').attr('href', "/events/#{event.id}")
      $('#event_popup').trigger('click')
  
  updateEvent = (event) ->  
    url = "/events/" + event.id
    $.ajax
      url: url
      method: 'PUT'
      data:
        event:
          start_date: event.start.format() 
          end_date: event.end.format()
