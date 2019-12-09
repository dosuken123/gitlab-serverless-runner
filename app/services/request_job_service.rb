class RequestJobService < BaseService
  def execute(runner)
    response = HTTParty.post("#{runner.url}/api/v4/jobs/request",
      body: { token: runner.token })

    return unless response.code == 201

    specification = response.parsed_response
    build_id = specification['id']
    token = specification['token']
    runner.jobs.create(build_id: build_id, token: token, specification: specification)
  end
end
