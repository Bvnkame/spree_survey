class AddIsLikeUserFood < ActiveRecord::Migration
  def change
  	remove_column :spree_users_foods, :is_like?
  	add_column :spree_users_foods, :is_like, :boolean
  end
end
