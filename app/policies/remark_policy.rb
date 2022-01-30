# frozen_string_literal: true

class RemarkPolicy < ApplicationPolicy
  def destroy?
    @record.lecture.course.user == @user || @record.user == @user || @user.has_role?(:admin)
  end
end