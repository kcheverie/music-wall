class RemoveUpvotes < ActiveRecord::Migration
  def change
    remove_column :songs, :upvotes
  end
end
