module Jobs
  class PatchTraceService
    def execute(job, chunk, offset)
      headers = {
        'Content-Range' => "#{offset}-#{offset + chunk.length}",
        'Content-Type' => 'text/plain',
        'HTTP_JOB_TOKEN' => job.token
      }

      HTTParty.patch("#{job.runner.url}/api/v4/jobs/#{job.build_id}/trace?token=#{job.token}",
        headers: headers, body: chunk)
    end
  end
end
