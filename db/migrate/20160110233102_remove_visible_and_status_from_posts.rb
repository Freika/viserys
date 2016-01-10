class RemoveVisibleAndStatusFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :visible, :boolean
    remove_column :posts, :status, :string
  end
end
