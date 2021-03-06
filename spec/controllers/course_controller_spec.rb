require 'rails_helper'

RSpec.describe V1::CoursesController, type: :controller do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:course_params) do
    { 
      title: 'Test title',
      description: 'Test description',
      difficulty: 'easy',
      language: 'english',
      price: '10',
      summary: 'Summary'
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      request.headers.merge!(headers)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'returns a success response' do
      request.headers.merge!(headers)
      post :create, params: { course: course_params }

      expect(response).to have_http_status(201)
      expect(Course.all.count).to eq(1)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      course = create(:course, user_id: user.id)
      request.headers.merge!(headers)
      get :show, params: { id: course.id }

      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'returns a success response' do
      course = create(:course, user_id: user.id)
      request.headers.merge!(headers)
      patch :update, params: { id: course.id, course: course_params }

      expect(response).to have_http_status(204)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns a success response' do
      course = create(:course, user_id: user.id)
      request.headers.merge!(headers)
      delete :destroy, params: { id: course.id }

      expect(response).to have_http_status(204)
    end
  end
end