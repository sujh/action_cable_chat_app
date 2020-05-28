class RoomChannelJob < ApplicationJob
  queue_as :default

  def perform(channel_name, **data)
    ActionCable.server.broadcast(channel_name, data)
  end
end
