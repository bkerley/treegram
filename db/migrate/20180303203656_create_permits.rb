class CreatePermits < ActiveRecord::Migration[5.1]
  def change
    create_table :permits do |t|
      t.datetime :notified_at
      t.datetime :status_date
      t.string :address
      t.st_point :location, geographic: true
      t.belongs_to :city_permit, foreign_key: true

      t.timestamps
    end
  end
end
