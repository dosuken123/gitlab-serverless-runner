class UpdateRunnerService < BaseService
  def execute(runner)
    if runner.concurrency < new_concurrency
      runner.reallocate_jobs(new_concurrency)
    elsif runner.concurrency > new_concurrency
      # NOTE: This could lose some running job information
      runner.deallocate_jobs(new_concurrency)
    end

    runner.update(params)
  end

  private

  def new_concurrency
    params[:concurrency].to_i
  end
end
