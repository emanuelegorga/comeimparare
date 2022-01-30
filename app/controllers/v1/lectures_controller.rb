# frozen_string_literal: true

module V1
  class LecturesController < ApplicationController
    before_action :set_lecture, only: :delete_video
    before_action :set_course, only: [:create, :index]
    before_action :set_course_and_lecture, only: [:show]

    def index
      @lectures = @course.lectures
      json_response(@lectures)
    end

    def show
      @authorize
      current_user.view_lecture(@lecture)
      json_response(@lecture)
    end

    def create
      @lecture = @course.lectures.create!(lecture_params)
      json_response(@lecture, :created)
    end

    def update
      @authorize
      @lecture.update(lecture_params)
      head :no_content
    end

    def destroy
      @authorize
      @lecture.destroy
      head :no_content
    end

    def delete_video
      authorize @lecture, :update?
      @lecture.video.purge if @lecture.video.attached?
      @lecture.video_thumbnail.purge if @lecture.video_thumbnail.attached?
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
      params.require(:lecture).permit(:title, :content, :video, :video_thumbnail)
    end
  end
end