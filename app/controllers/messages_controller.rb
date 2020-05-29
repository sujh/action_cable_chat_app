class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :get_messages

  def index
  end

  private

    def get_messages
      @room = Room.find(params[:room_id])
      @messages = @room.messages.for_display
      @message = current_user.messages.build(room_id: @room.id)
    end

    def message_params
      params.require(:message).permit(:content, :room_id)
    end
end
