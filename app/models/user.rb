class User < ActiveRecord::Base
  has_many :created_organizations, class_name: 'Organization', foreign_key: :owner_id

  validates :uid, presence: true
  validates :screen_name, presence: true
  validates :image_url, presence: true

  def self.create_with_omniauth(auth)
    create do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.screen_name = auth['info']['nickname']
      user.name = auth['info']['name']
      user.image_url = auth['info']['image']
    end
  end

  def update(auth)
      self.provider = auth['provider']
      self.uid = auth['uid']
      self.screen_name = auth['info']['nickname']
      self.name = auth['info']['name']
      self.image_url = auth['info']['image']
      self.save
  end
end
