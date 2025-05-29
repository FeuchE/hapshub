class AdventuresController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    if params[:query].present?
      @adventures = Adventure.search_by_name_and_description_and_location(params[:query]).where(event: @event)
    else
      @adventures = @event.adventures
    end
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  def update
    @adventure = Adventure.find(params[:id])
    @event = @adventure.event
    if @event.update(adventure: @adventure)
      redirect_to event_path(@event), notice: "You have chosen #{@adventure.name}"
    else
      redirect_to adventures_path, notice: "Something went wrong"
    end
  end
end
