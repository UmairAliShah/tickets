json.extract! profile, :id, :first_name, :last_name, :nick_name, :gender, :DOB, :phone, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
