require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'should return proper json' do
      create_list :course, 2
      
      get :index

      Course.recent.each_with_index do |course, index|
        expect(parsed_data[index]['attributes']).to eq({
          'id' => course.id,
          'title' => course.title,
          'description' => course.description,
          'price' => course.price,
          'language' => course.language,
          'metadata' => course.metadata,
          'difficulty' => course.difficulty 
        })
      end
    end
  end

  describe 'POST #create' do
    it 'returns a success response' do
      post :create, params: { course: { title: 'Test title', description: 'Test description' } }

      expect(response).to have_http_status(201)
      expect(Course.all.count).to eq(1)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      course = FactoryBot.create(:course)

      get :show, params: { id: course.id }

      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    it 'returns a success response' do
      course = FactoryBot.create(:course)

      patch :update, params: { id: course.id, course: { title: 'Test title', description: 'Test description' } }

      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns a success response' do
      course = FactoryBot.create(:course)

      delete :destroy, params: { id: course.id }

      expect(response).to have_http_status(204)
    end
  end
end