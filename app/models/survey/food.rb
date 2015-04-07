module Survey
	class Food < ActiveRecord::Base
		self.table_name = "foods"
		has_many :users, through: :user_foods, :class_name => "Spree::User"
		has_many :user_foods, :class_name => "Survey::UserFood", foreign_key: 'user_id'


		def save_like(user)
			user.foods << self
			user.save
			@userfoods = Survey::UserFood.where(user_id: user.id, food_id: self.id).last
			@userfoods.is_like = true
			@userfoods.save
		end

		def save_unlike(user)
			user.foods << self
			user.save
			@userfoods = Survey::UserFood.where(user_id: user.id, food_id: self.id).last
			@userfoods.is_like = false
			@userfoods.save
		end

	end
end 