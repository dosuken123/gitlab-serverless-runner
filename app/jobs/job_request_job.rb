class JobRequestJob < Jets::Job::Base
  # Adjust to increase the default timeout for all Job classes
  class_timeout 60

  rate "10 seconds"
  def job_request
    JobRequestService.new.execute
  end
end
