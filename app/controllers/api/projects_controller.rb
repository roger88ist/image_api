class Api::ProjectsController < ActionController::API

  def index
    render json: Project.all
  end
end