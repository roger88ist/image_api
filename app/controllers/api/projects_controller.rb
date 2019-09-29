class Api::ProjectsController < ActionController::API

  before_action :allow_response_access, only: [:create]

  def index
    render json: Project.all
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :creator_email, :image)
  end

  def allow_response_access
    response.set_header('Access-Control-Allow-Origin', '*')
  end
end