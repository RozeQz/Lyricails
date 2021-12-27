# frozen_string_literal: true

json.extract! user, :id, :username, :email, :last_login_at, :created_at, :updated_at
json.url user_url(user, format: :json)
