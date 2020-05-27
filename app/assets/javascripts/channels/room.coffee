App.room = App.cable.subscriptions.create "RoomChannel",
  connected: (data) ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data['type'] == 'chat'
      App.room.show_conversation(data['username'], data['message'])
    else if data['type'] == 'inform'
      App.room.show_inform(data['message'])

    # Called when there's incoming data on the websocket for this channel

  speak: ->
    words = $('textarea#message_content').val().replace(/\n/g, '<br/>')
    if words.length > 0
      @perform 'speak', message: words
      $('textarea#message_content').val('')

  show_conversation: (user, msg) ->
    fragment = """
      <div class='message'>
        <div class='message-user'>#{user}</div>
        <div class='message-content'>#{msg}</div>
      </div>"""
    $('#messages-table').append(fragment)

  show_inform: (msg) ->
    fragment = """<div class='message-inform'>#{msg}</div>"""
    $('#messages-table').append(fragment)

  leave: ->
    @perform 'unsubscribed'

  $(document).on 'keypress', 'textarea#message_content', (event) ->
    if event.ctrlKey && event.keyCode is 13
      App.room.speak()
      event.preventDefault()

  $(document).on "submit", 'form#new_message', (event) ->
    App.room.speak()
    event.preventDefault()

  $(document).on 'click', '.leave', (event) ->
    App.room.leave