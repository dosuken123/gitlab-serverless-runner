module Runners
  class RequestJobService < BaseService
    def execute(runner)
      response = HTTParty.post("#{runner.url}/api/v4/jobs/request",
        body: { token: runner.token })

      return unless response.code == 201

      spec = response.parsed_response
      runner.jobs.create!(spec: spec)

      success
    end
  end
end
