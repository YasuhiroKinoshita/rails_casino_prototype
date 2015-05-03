class Member < ActiveRecord::Base
  belongs_to :user
  has_one :cashier

  validates :organization_id, presence: true
  validates :user_id, presence: true
end
