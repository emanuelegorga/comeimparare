# frozen_string_literal: true

module V1
  class OrdersController < ApplicationController
    before_action :set_order, only: [:update, :show]

    def create
      order = @current_user.orders.build(
        payment_method: params[:metodo_pagamento]
      )
      courses = params[:corsi].map { |course_id| Course.find(course_id) }

      courses.each do |course|
        join = @current_user.join_course(course)
        order.courses << course.id
        order.total += course.price
      end

      if @current_user.metadata[:stripe_id].nil?
        customer = Stripe::Customer.create(
          email: @current_user.email,
          source: params[:stripeToken]
        )
        customer_id = customer.id
        @current_user.metadata[:stripe_id] = customer_id
        @current_user.save!
      else
        customer_id = @current_user.metadata[:stripe_id]
      end

      payment_intent = Stripe::PaymentIntent.create(
        amount: order.total * 100,
        currency: 'eur',
        customer: customer_id,
        automatic_payment_methods: {
          enabled: true,
        }, 
      )

      order.metadata['client_secret'] = payment_intent['client_secret']
      order.metadata['payment_id'] = payment_intent.id
      order.save!
      json_response(order, :created)
    end

    def show
      return json_response(@order) if @order.paid_at

      payment_intent = Stripe::PaymentIntent.retrieve(
        @order.metadata['payment_id']
      )

      if payment_intent.status == 'succeeded'
        @order.paid_at = Time.now
        @order.save!
      end

      json_response(@order)
    end

    def index
      json_response(@current_user.orders)
    end

    def full_list
      authorize @current_user
      json_response(Order.all)
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(
        :ordine_items,
        :metodo_pagamento,
        :prezzo_totale,
        :corsi
      )
    end
  end
end
