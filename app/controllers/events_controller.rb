class EventsController < ApplicationController
  before_action :set_group, only: %w[new create]

  def index
    @events = Event.all
  end

  def show
    @adventure = Adventure.find(params[:id])
    @event = Event.find(params[:id])
    @event.adenture = @adventure
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.group = @group
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event), notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def event_params
    params.require(:event).permit(:start_time, :end_time, :location, :category)
  end
end
