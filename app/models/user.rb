class User < ActiveRecord::Base
  attr_accessor :login

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :authentication_keys => [:login]
  has_many :posts

  validates :name,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      if conditions[:name].nil?
        where(conditions).first
      else
        where(name: conditions[:name]).first
      end
    end
  end

end
