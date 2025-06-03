class AdventuresController < ApplicationController
  before_action :set_event
  before_action :set_adventure, only: %i[show update]

  def index
    @event = Event.find(params[:event_id])
    if params[:query].present?
      @adventures = Adventure.search_by_name_and_description_and_location(params[:query]).where(event: @event)
    else
      @adventures = @event.adventures
    end
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

  def show
    @adventure
  end

  def update
    @event = @adventure.event
    @event.adventure = @adventure
    if @event.save
      redirect_to event_path(@event),
                  notice: "You have chosen your adventure!"
    else
      flash.now[:alert] = "Something went wrong"
      render :show
    end
  end

private
  def set_event
    @event = Event.find(params[:event_id])
  end
  def set_adventure
    @adventure = @event.adventures.find(params[:id])
  end
  def adventure_params
    params.require(:adventure).permit(:name, :description, :location, :start_time, :end_time)
  end
end
