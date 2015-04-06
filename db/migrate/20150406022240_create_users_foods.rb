class CreateUsersFoods < ActiveRecord::Migration
  def change
     create_table :spree_users_foods do |t|
      t.integer :user_id
      t.integer :food_id
    end

    add_foreign_key :spree_users_foods, :spree_users, column: 'user_id'
    add_foreign_key :spree_users_foods, :foods
  end
end
