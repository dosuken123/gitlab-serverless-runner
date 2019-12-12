module Jobs
  class ExecuteScriptService < BaseService
    def execute(job)
      Jobs::Script.generate!(job) do |script_path|
        if system(script_path)
          success
        else
          error(failure_reason: 'script_failure')
        end
      end
    end
  end
end
