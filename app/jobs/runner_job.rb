class RunnerJob < Jets::Job::Base
  # Adjust to increase the default timeout for all Job classes
  class_timeout 60

  rate '1 minute'
  def request_jobs
    Runner.has_capacity.find_each do |runner|
      RequestJobsService.new.execute(runner)
    end
  end

  def report_result(runner_job_id)
    RunnerJob.find_by_runner_job_id(runner_job_id).try do |runner_job|
      response = HTTParty.post("#{runner.url}/api/v4/jobs/request", body: { token: runner.token })

      return unless response.status == 201

      runner_job.recycle!
    end
  end
end
