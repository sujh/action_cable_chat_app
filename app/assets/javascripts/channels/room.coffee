App.room = App.cable.subscriptions.create "RoomChannel",
  connected: (data) ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    fragment = """
      <div class='message'>
        <div class='message-user'>#{data['username']}</div>
        <div class='message-content'>#{data['message']}</div>
      </div>"""
    $('#messages-table').append(fragment)

    # Called when there's incoming data on the websocket for this channel

  speak: ->
    words = $('textarea#message_content').val().replace(/\n/g, '<br/>')
    if words.length > 0
      @perform 'speak', message: words
      $('textarea#message_content').val('')

  $(document).on 'keypress', 'textarea#message_content', (event) ->
    if event.ctrlKey && event.keyCode is 13
      App.room.speak()
      event.preventDefault()

  $(document).on "submit", 'form#new_message', (event) ->
    App.room.speak()
    event.preventDefault()