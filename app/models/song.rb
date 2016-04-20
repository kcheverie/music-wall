class Song < ActiveRecord::Base
  STARTING_UPVOTES = 0

  belongs_to :user
  has_many :upvotes, :songs

  validates :title, :author,
  presence: true

end