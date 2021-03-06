require_relative "./concerns/csvable"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  validates_presence_of :last_name
  validates_presence_of :first_name
  validates_acceptance_of :tos_agreement, :allow_nil => false, :accept => true, :on => :create
  profanity_filter! :first_name, :last_name


  has_many :microposts

  CSV_COLUMN_NAMES = %w(email first_name last_name microposts_count)

  include Csvable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end

  def microposts_count
    microposts.count
  end

end
