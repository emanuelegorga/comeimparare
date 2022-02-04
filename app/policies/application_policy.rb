# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end

  # shared methods
  def is_admin_or_course_owner?
    is_admin? || is_course_owner?
  end
  def is_admin?
    @user.present? && @user&.has_role?(:admin)
  end
  def is_teacher?
    @user.present? && @user&.has_role?(:teacher)
  end
  def is_course_owner?
    @user.present? && @record.present? && @record&.user == @user
  end
  def joined_course?
    @user.present? && @record.present? && !@record.course.already_joined?(@user)
  end
  def is_admin_or_teacher?
    is_admin? || is_teacher?
  end
  def is_lecture_owner?
    @user.present? && @record.present? && @record.course.user_id == @user.id
  end
  def is_admin_or_lecture_owner?
    is_admin? || is_lecture_owner?
  end
  def is_join_owner?
    @user.present? && @record.present? && @record.user_id == @user.id
  end
  def is_admin_or_user_owner?
    is_admin? || @user.present? && @record.id == @user.id
  end
end