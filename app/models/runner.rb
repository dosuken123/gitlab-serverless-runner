class Runner < ApplicationRecord
  has_many :jobs

  validates :url, presence: true
  validates :token, presence: true
  validates :concurrency, inclusion: { in: 1..10 }

  enum runtime: {
    ruby_2_5: 0
  }

  scope :has_capacity,
    -> { where('(SELECT COUNT(*) FROM jobs WHERE runners.id = jobs.runner_id) > concurrency') }

  def has_capacity?
    jobs.count < concurrency
  end

  def capacity
    concurrency - jobs.count
  end
end
