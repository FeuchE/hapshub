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

  def index
    @notifications = current_user.notifications
  end

  def update
  @notification = Notification.find(params[:id])
  if @notification.user == current_user
    if @notification.update(attending: params[:attending])
      redirect_to notifications_path, notice: 'Notification updated.'
    else
      redirect_to notifications_path, alert: 'Failed to update notification.'
    end
  else
    head :unauthorized
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
