class EventsController < ApplicationController
  before_action :set_group, only: %i[new create show]
  before_action :set_event, only: %i[show destroy]
  before_action :authorize_event_owner!, only: %i[destroy]
    skip_before_action :authenticate_user!, only: [:index]

# app/controllers/events_controller.rb
def index
  @events = Event.all

  respond_to do |format|
    format.html
    format.json do
      render json: @events.map { |event|
        {
          id: event.id,
          start: event.start_time.to_date.to_s,
          end: (event.end_time.to_date + 1).to_s,
          title: '', # Empty so no text shows
          url: Rails.application.routes.url_helpers.event_path(event)
        }
      }
    end
  end
end



  def show
    # @event already set by before_action
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.group = @group if @group.present?
    @event.user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_adventures_path(@event), notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event deleted successfully." }
      format.json { head :no_content }
    end
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
