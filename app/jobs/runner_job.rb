class RunnerJob < Jets::Job::Base
  # Adjust to increase the default timeout for all Job classes
  class_timeout 900

  def run(job_id)
    Job.find_by_id(job_id).try do |job|
      if system(job.script)
        job.success!
      else
        job.failed!
      end

      job.runner.finish
    end
  end
end
