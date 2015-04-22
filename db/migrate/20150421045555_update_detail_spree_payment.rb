class UpdateDetailSpreePayment < ActiveRecord::Migration
  def change
  	add_column :spree_payments, :payment_type, :string, :default => "Cash"
  	add_column :spree_payments, :is_pay, :boolean
  end
end
