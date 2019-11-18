class Runner < ApplicationRecord
  validates :token, presence: true

  enum runtime: {
    ruby_2_5: 0
  }
end
