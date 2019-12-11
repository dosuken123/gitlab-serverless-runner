class Job < ApplicationRecord
  belongs_to :runner

  def trace_path
    File.join(trace_dir, "#{id}.log").tap do |path|
      FileUtils.touch(path)
    end
  end

  private

  def trace_dir
    File.join(Jets.root, 'traces')
  end
end
