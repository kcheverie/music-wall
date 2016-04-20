class Upvote < ActiveRecord::Base
  belongs_to :user, :song
end