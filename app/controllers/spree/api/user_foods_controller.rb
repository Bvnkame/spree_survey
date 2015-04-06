module Spree
	module Api
		class UserFoodsController < BaseApiController
			before_action :authenticate_user

			def index
				@foods = user.foods
				render "spree/api/foods/index"
			end

			def create
				@user = Spree::User.find(params["user_id"])
				if @user
					Survey::UserFood.transaction do
						food_params[:ids].split(',').each do |id|
							@food = Survey::Food.find(id)
							if @food
								@user.foods << @food
								@user.save
							else
								invalid_resource!(@food)
							end
						end
					end
					@status = [ { "messages" => "Add Food Suvery to User Successful"}]
					render "spree/api/logger/log", status: 200
				end
			end

			private

			def food_params
				params.require(:food).permit(:ids)
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