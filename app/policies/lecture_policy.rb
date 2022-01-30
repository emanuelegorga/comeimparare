# frozen_string_literal: true

class LecturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
  end

  def create?
    is_admin_or_lecture_owner?
  end

  def show?
    is_admin_or_lecture_owner? || joined_course?
  end

  def update?
    is_admin_or_lecture_owner?
  end

  def destroy?
    is_admin_or_lecture_owner?
  end
end