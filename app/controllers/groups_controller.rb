class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
   @upcoming_events = @group.events
                          .where('start_time >= ?', Time.current)
                          .order(:start_time) # You can add filtering here if needed
  end
end
