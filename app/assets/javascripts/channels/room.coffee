$(document).on 'turbolinks:load', ->
  if $('body').data('controller-name') is 'messages'
    App.room = App.cable.subscriptions.create channel: "RoomChannel", room_id: window.location.pathname.match(/rooms\/(\d+)/)[1],
      connected: (data) ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        if data['type'] is 'chat'
          @show_chat(data['username'], data['message'])
        else if data['type'] is 'inform'
          @show_inform(data['message'])

        # Called when there's incoming data on the websocket for this channel

      speak: ->
        words = $('textarea#message_content').val()
        if words.replace(/\n/g, '').length > 0
          @perform 'speak', message: words
          $('textarea#message_content').val('')

      show_chat: (user, msg) ->
        escapedMsg = msg.replace(/<(.+?)>/g, "&lt;$1&gt;").replace(/\n/g, '<br>').replace(/\s/g, '&nbsp;')
        fragment = """
          <div class='message'>
            <div class='message-user'>#{user}</div>
            <div class='message-content'>#{escapedMsg}</div>
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
      App.room.leave()