class RunnerBuild < ApplicationRecord
  belongs_to :runner

  scope :unassigned, -> { where(build_id: nil) }
  scope :assigned, -> { where.not(build_id: nil) }
end
