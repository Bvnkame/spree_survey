module Survey
	class UserSurvey < ActiveRecord::Base
		self.table_name = "user_surveys"


		def self.save_info(user, quantity, something)
			@user_survey = Survey::UserSurvey.new
			@user_survey.user_id = user.id
			@user_survey.quantity = quantity
			@user_survey.something = something
			@user_survey.save
		end
	end
end 