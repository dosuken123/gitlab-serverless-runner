class RunnerJobsJob < Jets::Job::Base
  # Adjust to increase the default timeout for all Job classes
  class_timeout 60

  def report_result(runner_job_id)
    RunnerJob.find_by_runner_job_id(runner_job_id).try do |runner_job|
      response = HTTParty.post("#{runner.url}/api/v4/jobs/request", body: { token: runner.token })

      retry unless response.status == 201

      runner_job.recycle!
    end
  end
end
