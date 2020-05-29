class RoomChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    room = Room.find(params[:room_id])
    stream_for room
    RoomChannelJob.perform_later(params[:room_id], message: "#{current_user.username} has entered", type: 'inform')
  end

  def unsubscribed
    RoomChannelJob.perform_later(params[:room_id], message: "#{current_user.username} has left", type: 'inform')
    stop_all_streams
  end

  def speak(data)
    RoomChannelJob.new.perform(params[:room_id],
                                 message: data['message'],
                                 username: current_user.username,
                                 type: 'chat',
                                 user_id: current_user.id)
  end
end
