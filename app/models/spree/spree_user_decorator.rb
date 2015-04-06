Spree::User.class_eval do 
	has_many :foods, through: :user_foods, :class_name => "Survey::Food"
	has_many :user_foods, :class_name => "Survey::UserFood", foreign_key: 'user_id'

	has_many :user_surveys, :class_name => "Survey::UserSurvey", foreign_key: 'user_id'
end
