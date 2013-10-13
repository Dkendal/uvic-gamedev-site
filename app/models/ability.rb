class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    case
    when user.has_role?( :admin )
      can :manage, :all
    when user.persisted?
      can :create, Event
    end
    can :read, :all
  end
end
