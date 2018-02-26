class User < ApplicationRecord
  has_one :profile
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers:  [:facebook]#, :confirmable



   def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0,20]
          #user.fullname = auth.info.name
          #user.image = auth.info.image
          user.uid = auth.uid
          user.provider = auth.provider
          # If you are using confirmable and the provider(s) you use validate emails,
          # uncomment the line below to skip the confirmation emails.
          #user.skip_confirmation!
          user.save!
        end
       #user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
         #user.email = auth.info.email
        # user.password = Devise.friendly_token[0,20]
       #end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end



end
