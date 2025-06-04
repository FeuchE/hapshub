class PagesController < ApplicationController
  def home
    if user_signed_in?
      @upcoming_events = current_user.events.where("start_time >= ?", Time.current).order(:start_time)
    else
      @upcoming_events = []
    end

    @event_dates = @upcoming_events.map do |event|
      {
        title: event.adventure&.name || event.location || "Event",
        start: event.start_time.iso8601,
        end: event.end_time.iso8601
      }
    end.to_json
  end
end
