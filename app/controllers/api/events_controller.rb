class Api::EventsController < ApplicationController
  before_action :authenticate_user
  
  def index
    @events = Event.all

    render 'index.json.jb'
  end

  def create
    @event = Event.new(
                        user_id: 1,
                        name: params[:name],
                        location: params[:location],
                        description: params[:description],
                        start_time: params[:start_time],
                        end_time: params[:end_time],
                        )
    if @event.save
      render 'show.json.jb'
    else
      render json: {errors: @event.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
    render 'show.json.jb'
  end

  def update
    @event = Event.find(params[:id])

    @event.name = params[:name] || @event.name
    @event.location = params[:location] || @event.location
    @event.description = params[:description] || @event.description
    @event.start_time = params[:start_time] || @event.start_time
    @event.end_time = params[:end_time] || @event.end_time

    if @event.save
      render 'show.json.jb'
    else
      render json: {errors: @event.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    render json: {message: "It gone"}
  end

end
