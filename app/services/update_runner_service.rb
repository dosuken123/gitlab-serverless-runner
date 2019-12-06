class UpdateRunnerService < BaseService
  def execute(runner)
    runner.reallocate_build(new_concurrency)
    runner.update(params)
  end

  private

  def new_concurrency
    params[:concurrency].to_i
  end
end
