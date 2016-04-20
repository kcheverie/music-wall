class CreateUpvotesTable < ActiveRecord::Migration
  def change
    create_join_table :songs, :users, table_name: :upvotes
  end
end
