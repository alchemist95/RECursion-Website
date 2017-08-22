class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= current_user

    if user.admin?
      can :manage, :all
      can :access, :rails_admin
      can :dashboard
    else
      can :read, :all
      cannot :access, :rails_admin
    end

  end
end
