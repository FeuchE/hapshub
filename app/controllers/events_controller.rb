class EventsController < ApplicationController
  before_action :set_group, only: %i[new create show]

  def index
    if @group
      @events = @group.events # You can add `.upcoming` scope if defined
    else
      @events = Event.all # or Event.upcoming if you create that scope
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

  private

  def set_group
    @group = Group.find(params[:group_id]) if params[:group_id].present?
  end

  def event_params
    params.require(:event).permit(:start_time, :end_time, :location, :category)
  end
end
