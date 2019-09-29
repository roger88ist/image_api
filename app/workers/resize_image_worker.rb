class ResizeImageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(project_id)
    project = Project.find(project_id)
    project.image.variant(resize: '200x200!').processed
  end
end