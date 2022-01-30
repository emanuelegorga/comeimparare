# frozen_string_literal: true

module V1
  class CoursesController < ApplicationController
    before_action :set_course, only: %i[show update destroy accept reject publish unpublish]

    def index
      @courses = Course.published.accepted.paginate(page: params[:page], per_page: 20)
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

    def purchased
      @courses = Course.joins(:joins).where(joins: { user: current_user })
      json_response(@courses)
    end

    def pending_review
      @courses = Course.joins(:joins).merge(Join.pending_review.where(user: current_user))
      json_response(@courses)
    end

    def created
      @courses = Course.where({ user: current_user })
      json_response(@courses)
    end

    def from_different_teachers
      @courses = Course.where.not({user: current_user})
      json_response(@courses)
    end

    def accept
      @course.update_attribute(:accepted, true)
      json_response(@course)
    end

    def reject
      @course.update_attribute(:accepted, false)
      json_response(@course)
    end

    def publish
      @course.update_attribute(:published, true)
      json_response(@course)
    end

    def unpublish
      @course.update_attribute(:published, false)
      json_response(@course)
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
        :metadata,
        :published
      )
    end
  end
end
