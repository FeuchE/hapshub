class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @upcoming_events = @group.events # You can add filtering here if needed
  end
end
