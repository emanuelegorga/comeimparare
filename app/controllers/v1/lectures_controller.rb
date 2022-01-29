# frozen_string_literal: true

module V1
  class LecturesController < ApplicationController
    before_action :set_course, only: [:create, :index]
    before_action :set_course_and_lecture, only: [:show]

    def index
      @lectures = @course.lectures
      json_response(@lectures)
    end

    def show
      json_response(@lecture)
    end

    def create
      @lecture = @course.lectures.create!(lecture_params)
      json_response(@lecture, :created)
    end

    def update
      @lecture.update(lecture_params)
      head :no_content
    end

    def destroy
      @lecture.destroy
      head :no_content
    end

    private

    def set_course_and_lecture
      set_lecture
      set_course
    end

    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def lecture_params
      params.require(:lecture).permit(:title, :content)
    end
  end
end