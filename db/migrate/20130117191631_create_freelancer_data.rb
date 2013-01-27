class CreateFreelancerData < ActiveRecord::Migration
  def change
    create_table :freelancer_data do |t|
      t.string :status
      t.integer :daily_rate
      t.integer :user_id

      t.timestamps
    end
  end
end
