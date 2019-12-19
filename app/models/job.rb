class Job < ApplicationRecord
  belongs_to :runner

  after_commit :execute_async, on: :create

  def trace_path
    File.join(trace_dir, "#{id}.log").tap do |path|
      FileUtils.touch(path)
    end
  end

  private

  def trace_dir
    # Only /tmp seems to be writable in AWS Lambda.
    File.join('/tmp', 'traces').tap do |path|
      FileUtils.mkdir_p(path)
    end
  end

  def execute_async
    RunnerJob.perform_later(:execute_job, { job_id: self.id })
  end
end
