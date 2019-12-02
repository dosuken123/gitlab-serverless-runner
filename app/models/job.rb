class Job < ApplicationRecord
  belong_to :runner

  enum status: {
    created: 0,
    running: 1,
    success: 2,
    failed: 3,
  }
end
