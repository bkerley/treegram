class CreateCityPermits < ActiveRecord::Migration[5.1]
  def change
    create_table :city_permits do |t|
      t.string :plan_number
      t.string :property_address
      t.string :review_status
      t.datetime :review_status_changed_date

      t.timestamps
    end
  end
end
