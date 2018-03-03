class CreateCityPermits < ActiveRecord::Migration[5.1]
  def change
    create_table :city_permits do |t|
      t.string :plannumber
      t.string :propertyaddress
      t.string :reviewstatus
      t.datetime :reviewstatuschangeddate

      t.timestamps
    end
  end
end
