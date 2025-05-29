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

  def show
    @adventure
  end

  def update
    if @adventure.update(adventure_params)
      redirect_to event_adventure_path(@event, @adventure),
                  notice: "Adventure updated successfully"
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
