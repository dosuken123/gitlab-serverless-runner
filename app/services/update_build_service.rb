class UpdateBuildService
  def execute(runner_build, status)
    response = HTTParty.post("#{runner.url}/api/v4/jobs/request",
      body: { token: runner.token })

    return unless response.status == 201
  end
end
