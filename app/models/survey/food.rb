module Survey
	class Food < ActiveRecord::Base
		self.table_name = "foods"
		has_many :users, through: :user_foods, :class_name => "Spree::User"
		has_many :user_foods, :class_name => "Survey::UserFood", foreign_key: 'user_id'
	end
end 