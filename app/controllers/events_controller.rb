class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @user = current_user
    @group = Group.find(params[:group_id])
    if @event.save
      redirect_to event_path(@event), notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:start_time, :end_time, :location, :category)
  end
end
