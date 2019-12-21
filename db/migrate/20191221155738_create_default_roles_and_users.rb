class CreateDefaultRolesAndUsers < ActiveRecord::Migration[5.1]
  def self.up

    admin_user =  User.admin_user

    admin_user ||= User.create!(:email=>User::ADMIN[:email],:password=>User::ADMIN[:password])
    admin_role = Role.find_or_create_by(:name => Role::ROLES[:admin])
    member_role = Role.find_or_create_by(:name => Role::ROLES[:member])
    admin_user.role = admin_role
    admin_user.save!
  end

  def self.down

  end
end
