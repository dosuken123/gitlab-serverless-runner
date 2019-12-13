module Jobs
  class Script
    attr_reader :job

    FINISH_LOG = %Q{Job Finished!}.freeze

    FUNCTIONS = <<-EOS
function finalize {
  echo "#{FINISH_LOG}"
}
EOS

    TRAPS = <<-EOS
trap finalize EXIT
EOS

    def self.generate!(job)
      @job = job

      Dir.mktmpdir do |dir|
        script_path = File.join(dir, 'tmp-script')

        File.open(script_path, 'w') do |stream|
          stream.write("#!/bin/bash\n")
          stream.write("set -e\n")
          stream.write("#{FUNCTIONS}\n")
          stream.write("#{TRAPS}\n")
          stream.write("exec > #{job.trace_path} 2>&1\n")

          stream.write(%Q{echo "GitLab Serverless Runner Version: 0.1.0"\n})

          job.spec['variables'].each do |variable|
            stream.write(%Q{export #{variable['key']}="#{variable['value']}"\n})
          end

          job.spec['steps'].first['script'].each do |script|
            stream.write("#{script}\n")
          end
        end

        FileUtils.chmod("+x", script_path)

        yield script_path
      end
    end
  end
end
