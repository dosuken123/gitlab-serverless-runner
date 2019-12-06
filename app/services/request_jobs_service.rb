class RequestJobsService
  def execute(runner)
    runner.capacity.times do
      RequestJobService.new.execute(runner)
    end
  end
end
