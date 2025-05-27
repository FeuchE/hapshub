class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  # def create
  #   @event = Event.new(event_params)
  #   if @event.save
  #     redirect_to @event, notice: 'Event was successfully created.'
  #   else
  #     render :new
  #   end
  # end
end
