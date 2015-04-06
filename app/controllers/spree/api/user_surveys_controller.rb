module Spree
	module Api
		class UserSurveysController < BaseApiController
			before_action :authenticate_user

			def index
				@user_surveys = user.user_surveys
				render "spree/api/user_surveys/index"
			end

			def create
				@user = Spree::User.find(params["user_id"])
				if @user
					@user_survey = Survey::UserSurvey.new(user_survey_params)
					@user_survey.user_id = @user.id
					@user_survey.save
					@status = [ { "messages" => "Add User Survey Successful"}]
					render "spree/api/logger/log", status: 200
				end
			end

			private

			def user_survey_params
				params.require(:user_survey).permit(:quantity, :something)
			end

			def user_id
				params[:user_id]
			end

			def user
				Spree::User.find(user_id)
			end
		end 
	end
end