class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from params['channel']
    ActionCable.server.broadcast(params['channel'], message: "#{current_user.username} has entered", type: 'inform')
  end

  def unsubscribed
    ActionCable.server.broadcast(params['channel'], message: "#{current_user.username} has left", type: 'inform')
  end

  def speak(data)
    ActionCable.server.broadcast(params['channel'], message: data['message'], username: current_user.username, type: 'chat')
  end
end
