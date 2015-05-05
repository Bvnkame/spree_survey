module Spree
	module Api
		class SurveysController  < BaseApiController

			def create
				ActiveRecord::Base.transaction do
					#ADDRESS
					@time_delivery = Add::TimeDelivery.find(params[:time_delivery_id])

					address = Spree::Address.create(address_params)
					address.save!

					@order = Spree::Order.find_by!(number: params[:cart_number])
					@order.time_delivery_id = @time_delivery.id
					@order.ship_address_id = address.id
					@order.save

					#SURVEY CUSTOMER
					@user = Spree::User.find(current_api_user.id)
					Survey::UserSurvey.save_info(@user, user_survey_params[:quantity], user_survey_params[:something], @order.id)

					user_survey_params[:like_food_ids].split(',').each do |id|
						@food = Survey::Food.find(id)
						@food.save_like(@user, @order.id)
					end

					user_survey_params[:unlike_food_ids].split(',').each do |id|
						@food = Survey::Food.find(id)
						@food.save_unlike(@user, @order.id)
					end

					#PAYMENT
					Spree::Payment.where(:order_id => @order.id).destroy_all
					Spree::Payment.create(:order_id => @order.id, :payment_type => payment_params[:type], :is_pay => false)
				end
				@status = [ { "messages" => "Add Enter Information for User Successful"}]
				render "spree/api/logger/log", status: 200
			end


			def show
				@order = Spree::Order.find_by!(number: params[:order_number])
				 p "djfaksd"
				 p @order
				authorize! :update, @order

				render "spree/api/enter_informations/show"

			end

			def update

				@order = Spree::Order.find_by!(number: params[:cart_number])

				ActiveRecord::Base.transaction do
					#ADDRESS
					@time_delivery = Add::TimeDelivery.find(params[:time_delivery_id])

					@address = @order.ship_address.update(address_params)

					@order.time_delivery_id = @time_delivery.id
					@order.save

					#SURVEY CUSTOMER
					@user = Spree::User.find(current_api_user.id)

					@surveysomething = Survey::UserSurvey.find_by!(order_id: @order.id)
					@surveysomething.update_info(user_survey_params[:quantity], user_survey_params[:something])

					Survey::UserFood.where(user_id: @user.id, order_id: @order.id).destroy_all

					user_survey_params[:like_food_ids].split(',').each do |id|
						@food = Survey::Food.find(id)
						@food.save_like(@user, @order.id)
					end

					user_survey_params[:unlike_food_ids].split(',').each do |id|
						@food = Survey::Food.find(id)
						@food.save_unlike(@user, @order.id)
					end

					#PAYMENT
					@payment = Spree::Payment.find_by!(order_id: @order.id)
					@payment.update(:payment_type => payment_params[:type])

				end
				@status = [ { "messages" => "Update Enter Information for User Successful"}]
				render "spree/api/logger/log", status: 200
			end

			private 
			def address_params
				params.require(:address).permit(:user_name, :address1, :phone, :city, :district)
			end

			def user_survey_params
				params.require(:user_survey).permit(:quantity, :like_food_ids, :unlike_food_ids, :something)
			end

			def payment_params
				params.require(:payment).permit(:type)
			end
		end
	end
end 