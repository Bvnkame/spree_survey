class AddIsLikeUserFood < ActiveRecord::Migration
  def change
  	add_column :spree_users_foods, :is_like, :boolean
  end
end
