module Jobs
  class ExecuteJobService < BaseService
    def execute(job)
      thread = Thread.new { watch_trace(job) }
      result = ExecuteScriptService.new.execute(job)
      thread.join

      if result[:status] == :success
        UpdateJobService.new.execute(job, status: 'success')
      else
        UpdateJobService.new.execute(job, status: 'failed', failure_reason: result[:failure_reason])
      end

      success
    end

    def watch_trace(job)
      FileUtils.rm_f(job.trace_path)
      WatchTraceService.new.execute(job) do |chunk, offset|
        result = PatchTraceService.new.execute(job, chunk, offset)

        unless result[:status] == :success
          Jets.logger.warn "#{self.class.name} : #{__method__} : result[:message]: #{result[:message]}"
        end

        break if chunk =~ /#{Jobs::Script::FINISH_LOG}/
      end
    end
  end
end
