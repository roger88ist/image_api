class ProjectsController < ApplicationController
  
  def index
    @projects = Project.all
    @project = Project.new
  end

  def create
    Project.create(project_params)
    redirect_to root_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :creator_email, :image)
  end
end
