# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: %i[show update destroy]

      def index
        courses = Course.recent.page(current_page).per(per_page)
        render status: :ok, json: serializer.new(courses)
      end

      def show
        render json: serializer.new(@course)
      end

      def create
        course = Course.new(course_params)

        if course.save
          render status: :created, json: serializer.new(course)
        else
          render status: :unprocessable_entity, json: serializer.new(course.errors)
        end
      rescue => exception
        render status: :unprocessable_entity,
          adapter: :json_api,
          json: { 'details' => exception.message }
      end

      def update
        if @course.update(course_params)
          render status: :ok, json: serializer.new(@course)
        else
          render status: :unprocessable_entity, json: serializer.new(@course.errors)
        end
      rescue => exception
        render status: :unprocessable_entity, 
          adapter: :json_api,
          json: { 'details': exception.message }
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
          :difficulty,
          :language,
          :price,
          :metadata
        ) || ActionController::Parameters.new
      end

      def serializer
        CourseSerializer
      end
    end
  end
end
