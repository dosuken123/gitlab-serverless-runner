module Jobs
  class PatchTraceService < BaseService
    def execute(job, chunk, offset)
      headers = {
        'Content-Range' => "#{offset}-#{offset + chunk.length}",
        'Content-Type' => 'text/plain',
        'HTTP_JOB_TOKEN' => job.spec['token']
      }

      response = HTTParty.patch("#{job.runner.url}/api/v4/jobs/#{job.spec['id']}/trace?token=#{job.spec['token']}",
        headers: headers, body: chunk)

      response.code == 202 ? success : error(message: response.body)
    end
  end
end
