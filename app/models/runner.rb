class Runner < ApplicationRecord
  validates :url, presence: true
  validates :token, presence: true

  has_many :runner_jobs

  enum runtime: {
    ruby_2_5: 0
  }

  def assign_job_with(specification)
    runner_jobs.idle.limit(1).update_all(specification: specification)
  end

  def deassign_job_from(job_id)
    runner_jobs.find_by_job_id(job_id).recycle
  end
end
