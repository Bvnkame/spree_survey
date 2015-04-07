module Spree
	module Api
		class FoodsController  < BaseApiController
			before_action :authenticate_user, :except => [:index]

			def index
				if params[:ids]
					@foods =  Survey::Food.accessible_by(current_ability, :read).where(id: params[:ids].split(','))
				else
					@foods =  Survey::Food.all.ransack(params[:q]).result
				end
				render "spree/api/foods/index"
			end

			def create
				authorize! :create,  Survey::Food
				Survey::Food.create(food_params)
				@status = [ { "messages" => "Add Food Successful"}]
				render "spree/api/logger/log", status: 200
			end

			private

			def food_params
				params.require(:food).permit(:name)
			end
		end
	end
end 