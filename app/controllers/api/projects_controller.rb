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

  def thumbnail
    @project = Project.find(params[:id])

    render json: @project.image.variant(resize: '200x200!').processed
  rescue ActiveRecord::RecordNotFound
    render json: "Project ID: #{params[:id]} can't be found", status: :unprocessable_entity
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :creator_email, :image)
  end

  def allow_response_access
    response.set_header('Access-Control-Allow-Origin', '*')
  end
end