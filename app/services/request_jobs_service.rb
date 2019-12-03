class RequestJobsService
  def execute
    Runner.idle.find_each do |runner|
      response = HTTParty.post("#{runner.url}/api/v4/jobs/request",
                               body: { token: runner.token })
      
      next unless response.status == 201

      runner.assign_job_with(response.body)
    end
  end
end
