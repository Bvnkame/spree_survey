object @order

child :ship_address => :address do
	attributes :user_name, :phone, :address1, :city, :district
end

node(:time_delivery_id) { |p| p.time_delivery_id }

child :food_unlike => :food_unlike do
	attributes :food_id
end

child :food_like => :food_like do
	attributes :food_id
end

child :survey => :survey do
	attributes :quantity, :something
end

node(:payment_type) { |p| p.payment.payment_type } 
