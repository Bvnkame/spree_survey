class CreateUsersSurveys < ActiveRecord::Migration
  def change
    create_table :user_surveys do |t|
			t.integer :user_id
    	t.integer :quantity # How many people in your family?
    	t.string :something #Anything else we should know about your eating habits?

      t.timestamps
    end
  end
end
