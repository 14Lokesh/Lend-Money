class Loan < ApplicationRecord
  before_create :add_interest_rate

  belongs_to :user

  validates :amount, presence: true

  scope :requested, -> { where(state: "requested") }
  scope :closed_loans, ->(user_id) { where(user_id: user_id, state: "closed") }
  scope :requested_loans, ->(user_id) { where(user_id: user_id, state: "requested") }
  scope :pending_loans, ->(user_id) { where(user_id: user_id, state: "approved") }
  scope :open_loans, ->(user_id) { where(user_id: user_id, state: "open") }
  scope :rejected_loans, ->(user_id) { where(user_id: user_id, state: "rejected") }

  enum state: { requested: 'requested', approved: 'approved', open: 'open', closed: 'closed', rejected: 'rejected' }

  private

  def add_interest_rate
    self.interest_rate = 5.0
  end
end
