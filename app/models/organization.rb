class Organization < ActiveRecord::Base
  has_many :games
  has_many :members
  has_many :cashiers, through: :members
  has_many :users, through: :organization
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  validates :name, length: { maximum: 50 }, presence: true
  validates :owner_id, presence: true
end
