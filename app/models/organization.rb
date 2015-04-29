class Organization < ActiveRecord::Base
  has_many :cashiers
  has_many :games
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  validates :name, length: { maximum: 50 }, presence: true
  validates :owner_id, presence: true
end
