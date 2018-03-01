json.extract! product, :id, :title, :total_tickets, :sold_tickets, :short_description, :long_description, :approve, :count_down, :user_id, :admin_id, :created_at, :updated_at
json.url product_url(product, format: :json)
