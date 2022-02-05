# frozen_string_literal: true

module V1
  class CoursesController < ApplicationController
    skip_before_action :authorize_request, only: [:index, :show]
    before_action :set_course, only: [:show, :update, :destroy, :accept, :reject, :publish, :unpublish, :upload]

    def index
      # @courses = Course.published.accepted.paginate(page: params[:page], per_page: 20)
      @courses = Course.paginate(page: params[:page], per_page: 20)
      json_response(@courses)
    end

    def show
      json_response(@course)
    end

    def create
      @course = current_user.courses.new(course_params)
      authorize @course
      @course.save!
      json_response(@course, :created)
    end

    def update
      authorize @course
      @course.update(course_params)
      head :no_content
    end

    def destroy
      authorize @course
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
      authorize @course, :admin_power?
      @course.update_attribute(:accepted, true)
      json_response(@course)
    end

    def reject
      authorize @course, :admin_power?
      @course.update_attribute(:accepted, false)
      json_response(@course)
    end

    def publish
      authorize @course, :admin_power?
      @course.update_attribute(:published, true)
      json_response(@course)
    end

    def unpublish
      authorize @course, :admin_power?
      @course.update_attribute(:published, false)
      json_response(@course)
    end

    def upload
      if params[:logo]
        @course.logo.attach(params[:logo])
        @course.update(logo: url_for(@course.logo))
        json_response(@course)
      else
        json_response(@course, :unprocessable_entity)
      end
    end

    private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(
        :id,
        :title,
        :description,
        :summary,
        :difficulty,
        :language,
        :price,
        :metadata,
        :published,
        :accepted,
        :logo,
        :all
      )
    end
  end
end
