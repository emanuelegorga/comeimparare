# frozen_string_literal: true

class InstallPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end