class ExecuteScriptService < BaseService
  def execute(job)
    Jobs::Script.generate!(job) do |script_path|
      system(script_path)
    end
  end
end
