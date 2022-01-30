# frozen_string_literal: true

module V1
  class RemarksController < ApplicationController
    def create
      @course = Course.find(params[:course_id])
      @lecture = Lecture.find(params[:lecture_id])
      @remark = Remark.new(remark_params)
      @remark.lecture_id = @lecture.id
      @remark.user = current_user
      @remark.save!

      json_response(@remark, :created)
    end

    def destroy
      @course = Course.find(params[:course_id])
      @lecture = Lecture.find(params[:lecture_id])
      @remark = Remark.find(params[:id])
      authorize @remark
      @remark.destroy
      head :no_content
    end

    private

    def remark_params
      params.require(:remark).permit(:content)
    end

    def set_lecture
      @course = Course.find(params[:course_id])
      @lecture = Lecture.find(params[:lecture_id])
    end
  end
end