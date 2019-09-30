require 'spec_helper'
require 'sidekiq/testing'
require 'worker_helper'

Sidekiq::Testing.fake!

RSpec.describe ResizeImageWorker, type: :worker do 

  describe 'testing worker' do
    it 'goes into the jobs for testing environment' do
      expect{ described_class.perform_async }.to change(described_class.jobs, :size).by(1)
    end
  end
end