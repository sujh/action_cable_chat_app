class RoomChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_from params['channel']
    RoomChannelJob.perform_later(params['channel'], message: "#{current_user.username} has entered", type: 'inform')
  end

  def unsubscribed
    RoomChannelJob.perform_later(params['channel'], message: "#{current_user.username} has left", type: 'inform')
    stop_all_streams
  end

  def speak(data)
    RoomChannelJob.perform_later(params['channel'], message: data['message'], username: current_user.username, type: 'chat')
  end
end
