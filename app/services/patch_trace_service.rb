class PatchTraceService
  def execute(job, chunk, cur_position)
    headers = {
      'Content-Range' => "#{cur_position}-#{cur_position + chunk.length}",
      'Content-Type' => 'text/plain',
      'HTTP_JOB_TOKEN' => job.token
    }

    HTTParty.patch("#{job.runner.url}/api/v4/jobs/#{job.build_id}/trace?token=#{job.token}",
      headers: headers, body: chunk)
  end
end
