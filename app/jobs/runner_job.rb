class RunnerJob < Jets::Job::Base
  # Adjust to increase the default timeout for all Job classes
  class_timeout 60

  rate '1 minute'
  def request_jobs
    Runner.has_capacity.find_each do |runner|
      RequestJobsService.new.execute(runner)
    end
  end

  def execute_job
    Job.find_by_id(event[:job_id]).try do |job|
      Jobs::ExecuteJobService.new.execute(job)
    end
  end
end
