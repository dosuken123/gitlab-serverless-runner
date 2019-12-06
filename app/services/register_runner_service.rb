class RegisterRunnerService < BaseService
  def execute
    runner = Runner.new(params)

    return runner unless runner.valid?    

    response = HTTParty.post("#{runner.url}/api/v4/runners",
                             body: { token: runner.token })

    unless response.code == 201
      return runner.errors.add(:http, 'Failed to register it to GitLab Rails')
    end

    runner.token = response.parsed_response['token']
    runner.tap(&:save)
  end
end
