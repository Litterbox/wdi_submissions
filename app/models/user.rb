class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable, :omniauthable, :omniauth_providers => [:github]
  validates_presence_of :provider, :uid, :gh_nickname
  has_many :comments

  def self.find_for_gh_oauth omniauth_env
    user = where(omniauth_env.slice(:provider, :uid)).first_or_initialize

    unless user.persisted?
      user.name = omniauth_env.info.name
      user.avatar_url = omniauth_env.info.image
      user.gh_nickname = omniauth_env.info.nickname
      user.user_type = 'student'

      user.save!
    end

    user
  end
end
