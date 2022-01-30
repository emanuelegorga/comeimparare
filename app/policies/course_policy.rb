# frozen_string_literal: true

class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    is_admin_or_teacher?
  end

  def update?
    is_admin_or_course_owner?
  end

  def destroy?
    is_admin_or_course_owner?
  end
end