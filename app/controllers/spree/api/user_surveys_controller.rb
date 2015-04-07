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
					Survey::UserFood.transaction do
						Survey::UserSurvey.save_info(@user, user_survey_params[:quantity], user_survey_params[:something])

						user_survey_params[:like_food_ids].split(',').each do |id|
							@food = Survey::Food.find(id)
							if @food
								@food.save_like @user
							else
								invalid_resource!(@food)
							end
						end

						user_survey_params[:unlike_food_ids].split(',').each do |id|
							@food = Survey::Food.find(id)
							if @food
								@food.save_unlike @user
							else
								invalid_resource!(@food)
							end
						end
					end
					@status = [ { "messages" => "Add Survey for User Successful"}]
					render "spree/api/logger/log", status: 200
				end
			end

			private
			def user_survey_params
				params.require(:user_survey).permit(:quantity, :like_food_ids, :unlike_food_ids, :something)
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