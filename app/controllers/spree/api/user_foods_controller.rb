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

					@food = Survey::Food.find(food_params[:id])
					if @food
						@user.foods << @food
						@user.save
						@status = [ { "messages" => "Add Food Suvery to User Successful"}]
						render "spree/api/logger/log", status: 200
					else
						invalid_resource!(@food)
					end
				end
			end

			private

			def food_params
				params.require(:food).permit(:id)
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