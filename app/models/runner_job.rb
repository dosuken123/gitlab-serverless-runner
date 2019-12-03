class RunnerJob < ApplicationRecord
  belong_to :runner

  after_save :run, if: :ready_to_run?

  state_machine :status, initial: :idle do
    event :run do
      transition idle: :running
    end

    event :succeed do
      transition running: :success
    end

    event :drop do
      transition running: :failed
    end

    event :cancel do
      transition running: :canceled
    end

    event :recycle do
      transition any => :idle
    end

    before_transition any => :idle do |runner_job, transition|
      runner_job.specification = nil
    end
  end

  enum status: {
    idle: 0,
    running: 1,
    success: 2,
    failed: 3,
    canceled: 4,
  }

  def ready_to_run?
    idle? && specification_changed? && specification.present?
  end
end
