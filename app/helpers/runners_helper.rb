module RunnersHelper
  def concurrency
    runner.runner_jobs.count || 1
  end
end
