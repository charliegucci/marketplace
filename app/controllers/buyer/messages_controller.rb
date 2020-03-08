class Buyer::MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @listing = Listing.find(params[:listing_id])
    @message = Buyer::Message.new(buyer_email: current_user.email, buyer_name: current_user.name, listing_id: @listing.id)
  end
  
  def create
    @message = Buyer::Message.new(buyer_message_params)

    respond_to do |format|
      if @message.save
        @message.send!
        format.html { redirect_to @message, notice: "Message was successfully sent" }
      else
        format.html do
          flash[:alert] = "Email was not sent due to the following: #{@message.errors.full_messages.join(', ')}"
          render :new
        end
      end
    end
  end

  def show
    @message = Buyer::Message.find(params[:id])
  end
  
  protected

  def buyer_message_params
    params.require(:buyer_message).permit(:buyer_email, :buyer_name, :body, :listing_id)
  end
end
