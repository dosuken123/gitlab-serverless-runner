class Runner < ApplicationRecord
  validates :url, presence: true
  validates :token, presence: true

  has_many :jobs
  has_one :current_assigned_job, -> { created.limit(1).order(id: :desc) }, class_name: 'Job'
  has_one :current_running_job, -> { running.limit(1).order(id: :desc) }, class_name: 'Job'

  enum runtime: {
    ruby_2_5: 0
  }

  state_machine :status, :initial => :created do
    event :register do
      transition created: :idle
    end

    event :run do
      transition idle: :running
    end

    event :finish do
      transition assigned: :running
    end

    after_transition idle: :running do |runner, evaluator|
      job_info = evaluator.args.first

      job = runner.jobs.create!(job_info)

      RunnerJob.perform_later(:run, job.id)
    end
  end

  enum status: {
    created: 0,
    idle: 1,
    assigned: 2,
    running: 3
  }
end
