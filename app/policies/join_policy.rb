# frozen_string_literal: true

class JoinPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    is_admin?
  end

  def update?
    is_join_owner?
  end

  def destroy?
    is_admin?
  end

  def certificate?
    @record.course.lectures.count == @record.course.progress_tracks.where(user: @record.user).count
  end
end