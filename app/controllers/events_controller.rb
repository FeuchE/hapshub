class EventsController < ApplicationController
  before_action :set_group, only: %i[new create show]
  before_action :set_event, only: %i[show destroy]
  before_action :authorize_event_owner!, only: %i[destroy]

  def index
  if params[:group_id].present?
    @group = Group.find(params[:group_id])
    @events = @group.events
  else
    @events = Event.all
  end
end


  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.group = @group
    @event.user = current_user
    if @event.save
      redirect_to event_adventures_path(@event), notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

def destroy
  @event.destroy
  redirect_to events_path, notice: "Event deleted successfully."
end

  private

  def set_group
    @group = Group.find(params[:group_id]) if params[:group_id].present?
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_event_owner!
    unless @event.user == current_user
      redirect_to event_path(@event), alert: "You're not authorized to delete this event."
    end
  end

  def event_params
    params.require(:event).permit(:start_time, :end_time, :location, :category)
  end
end
