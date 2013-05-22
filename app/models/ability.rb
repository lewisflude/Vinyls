class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == "admin"
      can :manage, :all
    else
      can :read, :all
      can :create, Selection
      can :update, Selection do |selection|
        selection.try(:user) == user
      end
    end
  end
end
