Spree::Order.class_eval do 
	has_many :foods, through: :user_foods, :class_name => "Survey::Food"
	has_many :user_foods, :class_name => "Survey::UserFood", foreign_key: 'order_id'

	has_one :survey, :class_name => "Survey::UserSurvey", foreign_key: "order_id"

	has_one :payment, :class_name => "Spree::Payment", foreign_key: "order_id"

	def food_like
		self.user_foods.where(is_like: true)
	end

	def food_unlike
		self.user_foods.where(is_like: false)
	end
	
	
end
