class RequestJobService
  def execute(runner)
    response = HTTParty.post("#{runner.url}/api/v4/jobs/request",
      body: { token: runner.token })

    return unless response.status == 201

    specification = response.body
    build_id = specification[:build_id]
    token = specification[:token]
    runner.jobs.create(build_id, token, specification)
  end
end
