class RunnerJob < Jets::Job::Base
  # Adjust to increase the default timeout for all Job classes
  class_timeout 900

  def job_request(runner_job_id)
    RequestJobsService.new.execute
  end
end
