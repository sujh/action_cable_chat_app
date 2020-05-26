class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from params['channel']
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast(params['channel'], message: data['message'], username: current_user.username)
  end
end
