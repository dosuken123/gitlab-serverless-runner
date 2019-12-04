class Runner < ApplicationRecord
  validates :url, presence: true
  validates :token, presence: true

  has_many :runner_jobs

  validate :valid_concurrency?

  enum runtime: {
    ruby_2_5: 0
  }

  def assign_job_with(specification)
    runner_jobs.idle.limit(1).update_all(specification: specification)
  end

  def deassign_job_from(job_id)
    runner_jobs.find_by_job_id(job_id).recycle
  end

  def allocate_jobs(concurrency)
    concurrency.times { runner_jobs.build }
  end

  def reallocate_jobs(concurrency)
    extra = concurrency - self.concurrency
    extra.times { runner_jobs.build }
  end

  def deallocate_jobs(concurrency)
    shrink = self.concurrency - concurrency
    runner_jobs.limit(shrink).destroy_all
  end

  def concurrency
    @concurrency ||= runner_jobs.count
  end

  private

  def valid_concurrency?
    unless concurrency >= 1 && concurrency <= 10
      errors.add(:concurrency, 'must be between 1 and 10')
    end
  end
end
