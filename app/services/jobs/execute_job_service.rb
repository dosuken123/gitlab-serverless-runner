module Jobs
  class ExecuteJobService < BaseService
    def execute(job)
      thr = Thread.new { watch_trace(job) }

      result = ExecuteScriptService.new.execute(job)

      if result[:status] == :success
        UpdateJobService.new.execute(job, status: 'success')
      else
        UpdateJobService.new.execute(job, status: 'failed', failure_reason: result[:failure_reason])
      end

      success
    ensure
      Thread.kill(thr)
    end

    def watch_trace(job)
      WatchTraceService.new.execute(job) do |chunk, offset|
        PatchTraceService.new.execute(job, chunk, offset)
      end
    end
  end
end
