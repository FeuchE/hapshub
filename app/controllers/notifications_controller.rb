class NotificationsController < ApplicationController
 def new
    @event = Event.find(params[:event_id])
    @notification = Notification.new
  end

  def create
    @event = Event.find(params[:event_id])
    @group = @event.group
    @notification = @event.notifications.build(notification_params)
    if send_to_recipients(@event, @notification.message)

         redirect_to event_path(@event), notice: 'Notification sent successfully.'
    else
      render :new
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:message, :auto_generated)
  end

  def send_to_recipients(event, message)
    recipients = event.group.users.where.not(id: current_user.id)

     recipients.all? do |user|
      Notification.create!(user: user, event: event, message: message)

     end
  end
end
