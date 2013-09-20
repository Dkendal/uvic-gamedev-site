class Admin::Ability
  def current_ability
    @current_ability ||= Admin::Ability.new(current_user)
  end
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    case
    when user.has_role?( :admin )
      can :manage, :all
    when user.has_role?( :event_mod )
      can :manage, [ Event, Venue ]
    else
      cannot :read, :all
    end
  end
end
