require 'rails_helper'

RSpec.describe Api::ProjectsController do
  let(:project_attrs) {
    {
      name: 'first project',
      description: 'project to be used in test suite',
      creator_email: 'creator_email@mail.com'
    }
  }
  let(:file_path) { Rails.root.join('spec', 'factories', 'images', 'puppy.jpg') }
  let(:create_project) {
    project = Project.new(project_attrs)
    project.image.attach(io: File.open(file_path),
                           filename: 'puppy.jpg',
                           content_type: 'image/jpg')
    project.save
  }
  
  describe 'GET index' do
    before { 
      create_project
      get :index
    }

    it 'returns the list of projects with correct attributes' do
      project_keys = JSON.parse(response.body).first.keys
      
      expect(project_keys).to include('id', 'name', 'description', 'created_at')
    end

    it 'returns a 200 status' do
      expect(response).to have_http_status(:success)
    end
  end
end