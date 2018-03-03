json.extract! city_permit, :id, :plan_number, :property_address, :review_status, :review_status_changed_date, :created_at, :updated_at
json.url city_permit_url(city_permit, format: :json)
