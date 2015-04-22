module Spree
	module Api
		class SurveysController  < BaseApiController

			def create
				ActiveRecord::Base.transaction do
					#ADDRESS
					@time_delivery = Add::TimeDelivery.find(params[:time_delivery_id])

					if @time_delivery 
						address = Spree::Address.create(address_params)
						address.user_id = current_api_user.id
						address.save!
						@order = Spree::Order.find_by!(number: params[:cart_number])
						if @order
							@order.time_delivery_id = @time_delivery.id
							@order.ship_address_id = address.id
							@order.save
						end
					else
						invalid_resource!(@time_delivery)
					end

					#SURVEY CUSTOMER
					@user = Spree::User.find(current_api_user.id)
					if @user
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

					#PAYMENT
					Spree::Payment.create(:order_id => @order.id, :payment_type => payment_params[:type], :is_pay => false)
				end
				@status = [ { "messages" => "Add Enter Information for User Successful"}]
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

			def total_price_order(order)
				total_price = 0
				order.line_items.each do |line_item|
					p line_item
					total_price += line_item.price.to_f * line_item.quantity.to_f
				end
				total_price
			end
		end
	end
end 