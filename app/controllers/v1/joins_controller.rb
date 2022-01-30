# frozen_string_literal: true

module V1
  class JoinsController < ApplicationController
    skip_before_action :authorize_request, :only => [:certificate]

    before_action :set_join, only: [:show, :update, :destroy]
    before_action :set_course, only: [:index, :create]

    def index
      authorize @joins
      @joins = @course.joins.paginate(page: params[:page], per_page: 20)
      json_response(@joins)
    end

    def show
      json_response(@joins)
    end

    def create
      if @course.price > 0
        customer = Stripe::Customer.create(
          email: params[:stripeEmail],
          source: params[:stripeToken]
        )

        Stripe::Charge.create(
          customer:    customer.id,
          amount:      (@course.price * 100).to_i,
          description: @course.title,
          currency:    'eur'
        )
      end

      @join = current_user.join_course(@course)
      json_response(@join, :created)
    end

    def update
      authorize @join
      @join.update(join_params)
      head :no_content
    end

    def destroy
      authorize @join
      @join.destroy
      head :no_content
    end

    def my_students
      @joins = Join.joins(:course).where(courses: { user: current_user })
      json_response(@joins)
    end

    def certificate
      authorize @join, :certificate?
      json_response({})
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