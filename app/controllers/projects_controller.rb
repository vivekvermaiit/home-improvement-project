class ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects=policy_scope(Project).includes(:user)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    begin
      @project = policy_scope(Project).find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.html { redirect_to projects_url, notice: 'You are not allowed to view this project' }
        format.json { render json: { message: 'You are not allowed to view this project' }, status: 401 }
      end
      return
    end

  end

  # GET /projects/new
  def new
    @project = Project.new
    @editable_params = ProjectPolicy.new(current_user,@project).permitted_attributes_for_create
  end

  # GET /projects/1/edit
  def edit
    begin
      @project = policy_scope(Project).find(params[:id])
      @editable_params = ProjectPolicy.new(current_user,@project).permitted_attributes_for_update
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.html { redirect_to projects_url, notice: 'You are not allowed to edit this project' }
        format.json { render json: { message: 'You are not allowed to edit this project' }, status: 401 }
      end
      return
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(permitted_attributes(@project))
    @project.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(permitted_attributes(@project))
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    begin
      authorize @project
    rescue Pundit::NotAuthorizedError => e
      respond_to do |format|
        format.html { redirect_to projects_url, notice: 'You are not allowed to destroy this project' }
        format.json { render json: { message: 'You are not allowed to destroy this project' }, status: 401 }
      end
      return
    end

    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
end
