class ProjectPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def permitted_attributes_for_create
    [:name, :project_type, :description] #all
  end

  #user can only his own or edit description for public projects.
  def permitted_attributes_for_update
    if @user.admin? or @project.user == @user
      [:name, :project_type, :description] #all
    elsif @project.project_type == Project::PROJECT_TYPES[:public]
      [:description]
    else
      []
    end
  end

  def destroy?
    @user.admin? or @project.user == @user
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:project_type=>Project::PROJECT_TYPES[:public]).or(scope.where(:user=>@user))
      end
    end
  end

end