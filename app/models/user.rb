class User < ActiveMigration::Base
  has_many :songs
  validates :username, :email, :password,
    presence: true
end