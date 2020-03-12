class Buyer::MessagesController < ApplicationController
  before_action :authenticate_user!
# defines new buyer message passings current_user email, name and listing id
  def new
    @listing = Listing.find(params[:listing_id])
    @message = Buyer::Message.new(buyer_email: current_user.email, buyer_name: current_user.name, listing_id: @listing.id)
  end
# creates a new buyer/message
  def create 
    @message = Buyer::Message.new(buyer_message_params)

    respond_to do |format|
      if @message.save #checks if message is save
        @message.send! #checks if message is send
        format.html { redirect_to @message, notice: "Message was successfully sent" }
      else
        format.html do
          flash[:alert] = "Email was not sent due to the following: #{@message.errors.full_messages.join(', ')}"
          render :new
        end
      end
    end
  end
# show buyer/messages 
  def show
    @message = Buyer::Message.find(params[:id])
  end
  
  protected
# sanitized data being pass as params
  def buyer_message_params
    params.require(:buyer_message).permit(:buyer_email, :buyer_name, :body, :listing_id)
  end
end
