module Jobs
  class Script
    attr_reader :job

    def self.generate!(job)
      @job = job

      Dir.mktmpdir do |dir|
        script_path = File.join(dir, 'tmp-script')

        File.open(script_path, 'w') do |stream|
          stream.write("#!/bin/bash\n")
          stream.write("set -e\n")
          stream.write("exec > #{job.trace_path} 2>&1\n")

          job.specification['variables'].each do |variable|
            stream.write(%Q{export #{variable['key']}="#{variable['value']}"\n})
          end

          job.specification['steps'].first['script'].each do |script|
            stream.write("#{script}\n")
          end
        end

        FileUtils.chmod("+x", script_path)

        yield script_path
      end
    end
  end
end
