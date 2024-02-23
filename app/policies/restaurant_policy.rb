class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # In Pundit:
      # scope => `Restaurant` class (whatever is passed to the `#policy_scope`)
      # Then select the records that the user (current_user) can see. For example:
      # scope.where(user: user)
      # scope.where(published: true)
      scope.all
    end
  end

  def show?
    true
  end

  ## Not needed because identical to the #new? in the ApplicationPolicy
  # def new?
  #   create?
  # end

  def create?
    true
  end

  ## Not needed because identical to the #edit? in the ApplicationPolicy
  # def edit?
  #   update?
  # end

  def update?
    user_is_owner?
  end

  private

  def user_is_owner?
    # Only the owner of the restaurant is allowed to edit it
    # In Pundit:
    # record => restaurant (whatever is passed to the `#authorize`)
    # user => current_user

    # `restaurant.user == current_user` becomes:
    record.user == user
  end
end
