class LecturesController < ApplicationController

  def index
    @lectures = Lecture.all.order(held_on: :desc)
  end

  def show
    @lecture = Lecture.where(held_on: params[:held_on])
  end

end
