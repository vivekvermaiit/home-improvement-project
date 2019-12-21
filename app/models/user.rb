class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  ADMIN = {:email=>"admin@gmail.com",:password=>"123456"}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  belongs_to :role, default: -> {Role.member_role}

  def admin?
    self.role.name == Role::ROLES[:admin]
  end

  def member?
    self.role.name == Role::ROLES[:member]
  end

  def self.admin_user
    User.find_by_email(ADMIN[:email])
  end
end
