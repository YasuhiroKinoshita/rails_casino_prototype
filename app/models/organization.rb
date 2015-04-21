class Organization < ActiveRecord::Base
  has_many :cashiers
  has_many :games
end
