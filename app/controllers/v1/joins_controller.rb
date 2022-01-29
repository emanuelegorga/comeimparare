# frozen_string_literal: true

module V1
  class JoinsController < ApplicationController
    before_action :set_join, only: [:show, :update, :destroy]
    before_action :set_course, only: [:index, :create]

    def index
      @joins = @course.joins.paginate(page: params[:page], per_page: 20)
      json_response(@joins)
    end

    def show
      json_response(@joins)
    end

    def create
      @join = current_user.join_course(@course)
      json_response(@join, :created)
    end

    def update
      @join.update(join_params)
      head :no_content
    end

    def destroy
      @join.destroy
      head :no_content
    end

    def my_students
      @joins = Join.joins(:course).where(courses: { user: current_user })
      json_response(@joins)
    end

    private

    def set_join
      @join = Join.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:course_id])
    end

    def join_params
      params.require(:join).permit(:rating, :review)
    end
  end
end