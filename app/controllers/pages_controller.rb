class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if user_signed_in?
      @upcoming_events = current_user.events.where("start_time >= ?", Time.current).order(:start_time)
    else
      @upcoming_events = []
    end
  end
end
