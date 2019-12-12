module Jobs
  class UpdateJobService < BaseService
    VALID_STATUS = { 'running' => true, 'success' => true, 'failed' => true }.freeze
    FINISHED_STATUS = { 'success' => true, 'failed' => true }.freeze

    def execute(job, status: 'running', failure_reason: nil)
      return false unless VALID_STATUS[status]

      params_for_update = { token: job.spec['token'], id: job.spec['id'], state: status }
      params_for_update.merge!(failure_reason: failure_reason) if failure_reason

      response = HTTParty.put("#{job.runner.url}/api/v4/jobs/#{job.spec['id']}",
        body: params_for_update)

      return unless response.code == 200

      job.destroy! if FINISHED_STATUS[status]
    end
  end
end
