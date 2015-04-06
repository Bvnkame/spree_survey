module Survey
	class UserFood < ActiveRecord::Base
		self.table_name = "spree_users_foods"
		belongs_to :user, :class_name => "Spree::User", foreign_key: "user_id"
		belongs_to :food, :class_name => "Survey::Food", foreign_key: "food_id"
	end
end
