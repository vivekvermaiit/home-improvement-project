class Role < ApplicationRecord
  has_many :users
  ROLES = {:admin=>"admin",:member=>"member"}

  def self.member_role
    Role.find_by_name(ROLES[:member])
  end

  def self.admin_role
    Role.find_by_name(ROLES[:admin])
  end
end
