# frozen_string_literal: true

module SessionHelper
  def sign_in(user)
    jar = ActionDispatch::Cookies::CookieJar.build(request, response.cookies)
    jar.signed[:user_id] = { value: user.id, expires: 2.days, http_only: true }
    cookies.signed[:user_id] = { value: user.id, expires: 2.days, http_only: true }
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    jar = ActionDispatch::Cookies::CookieJar.build(request, response.cookies)
    jar.signed[:user_id] = nil
    cookies.signed[:user_id] = nil
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  # ||= означает, что если сurrent_user имеет значение nil,
  # то мы присваиваем ему значение, указанное ниже.
  # Если не nil, то мы присваиваем ему значение @current_user.
  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end
end
