class AddOrderIdForSpreeSurvey < ActiveRecord::Migration
  def change
  	add_column :spree_users_foods, :order_id, :integer
  	add_column :user_surveys, :order_id, :integer
  end
end
