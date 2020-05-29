class RoomChannelJob < ApplicationJob
  queue_as :default

  def perform(model_id, **data)
    room = Room.find(model_id)
    if room.traced? && data[:type] == 'chat'
      room.messages.create(user_id: data[:user_id], content: data[:message])
    end
    RoomChannel.broadcast_to(room, data)
  end
end
