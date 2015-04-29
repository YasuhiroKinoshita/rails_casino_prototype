class User < ActiveRecord::Base
  has_many :cashiers
  has_many :created_organizations, class_name: 'Organization', foreign_key: :owner_id

  def self.create_with_omniauth(auth)
    create do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.screen_name = auth['info']['nickname']
      user.name = auth['info']['name']
    end
  end
end
