# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    is_admin?
  end

  def show?
    is_admin_or_user_owner?
  end

  def update?
    is_admin_or_user_owner?
  end

  def destroy?
    is_admin_or_user_owner?
  end
end