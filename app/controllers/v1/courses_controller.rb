# frozen_string_literal: true

module V1
  class CoursesController < ApplicationController
    before_action :set_course, only: %i[show update destroy]

    def index
      @courses = Course.all.paginate(page: params[:page], per_page: 20)
      json_response(@courses)
    end

    def show
      json_response(@course)
    end

    def create
      @course = current_user.courses.create!(course_params)
      json_response(@course, :created)
    end

    def update
      @course.update(course_params)
      head :no_content
    end

    def destroy
      @course.destroy
      head :no_content
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(
        :title,
        :description,
        :summary,
        :difficulty,
        :language,
        :price,
        :metadata
      )
    end
  end
end
