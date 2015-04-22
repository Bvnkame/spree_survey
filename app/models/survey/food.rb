module Survey
	class Food < ActiveRecord::Base
		self.table_name = "foods"
		has_many :users, through: :user_foods, :class_name => "Spree::User"
		has_many :user_foods, :class_name => "Survey::UserFood", foreign_key: 'user_id'


		def save_like(user, order_id)
			user.foods << self
			user.save
			@userfood = Survey::UserFood.where(user_id: user.id, food_id: self.id).last
			@userfood.is_like = true
			@userfood.order_id = order_id
			@userfood.save
		end

		def save_unlike(user, order_id)
			user.foods << self
			user.save
			@userfood = Survey::UserFood.where(user_id: user.id, food_id: self.id).last
			@userfood.is_like = false
			@userfood.order_id = order_id
			@userfood.save
		end

	end
end 