module Survey
	class UserSurvey < ActiveRecord::Base
		self.table_name = "user_surveys"


		def self.save_info(user, quantity, something, order_id)
			@user_survey = Survey::UserSurvey.new
			@user_survey.user_id = user.id
			@user_survey.quantity = quantity
			@user_survey.something = something
			@user_survey.order_id = order_id
			@user_survey.save
		end

		def update_info(quantity, something)
			self.quantity = quantity
			self.something = something
			self.save!
		end
	end
end 