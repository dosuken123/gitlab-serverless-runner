class Runner < ApplicationRecord
  validates :url, presence: true
  validates :token, presence: true

  has_many :runner_builds

  validate :valid_concurrency?

  enum runtime: {
    ruby_2_5: 0
  }

  def assign_build(build_id, token, specification)
    runner_builds.unassigned.limit(1)
      .update_all(build_id: build_id, token: build_id, specification: specification) > 0
  end

  def free_build(buld_id)
    runner_builds.where(build_id: buld_id)
      .update_all(build_id: build_id, token: build_id, specification: specification)
  end

  def reallocate_builds(new_concurrency)
    cur_concurrency = concurrency

    if new_concurrency > cur_concurrency
      (new_concurrency - cur_concurrency).times { runner_builds.build }
    elsif new_concurrency < cur_concurrency
      runner_builds.limit(cur_concurrency - new_concurrency).destroy_all
    end
  end

  def concurrency
    runner_builds.count
  end

  private

  def valid_concurrency?
    cur_concurrency = concurrency

    unless cur_concurrency >= 1 && cur_concurrency <= 10
      errors.add(:concurrency, 'must be between 1 and 10')
    end
  end
end
