module Jobs
  ##
  # This service keeps watching trace.
  # The process has to be terminated (killed) after the job is done.
  class WatchTraceService < BaseService
    def execute(job)
      File.open(job.trace_path, 'r') do |stream|
        stream.extend(File::Tail)
        stream.seek(0, IO::SEEK_END)
        offset = stream.tell

        stream.tail do |line|
          yield line, offset
          offset = stream.tell
        end
      end
    end
  end
end
