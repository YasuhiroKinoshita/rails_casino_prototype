class Member < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  has_many :cashiers

  validates :organization_id, presence: true
  validates :user_id, presence: true
end
