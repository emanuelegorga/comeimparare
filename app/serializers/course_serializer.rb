# frozen_string_literal: true

class CourseSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :id, 
              :title, 
              :description, 
              :difficulty,
              :language,
              :price,
              :metadata
end