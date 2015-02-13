class EventsController < ApplicationController

  def index
    @events = Event.all
    @allEvents = []
    @events.each do |event|
      @allEvents << {
        :id => event.id,
        :title => event.title,
        :description => event.description,
        :start => "#{event.start_date.strftime("%Y-%m-%d %H:%M")}",
        :end => "#{event.end_date.strftime("%Y-%m-%d %H:%M")}"
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @allEvents }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update_attributes!(event_params)

    return render json: @event
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date)
  end
end
