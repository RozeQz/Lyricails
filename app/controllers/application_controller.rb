# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorHandling
  include SessionHelper

  before_action :require_login
  before_action :update_last_login_at, if: lambda {
                                             user_signed_in? &&
                                               (current_user.last_login_at.nil? || current_user.last_login_at < 3.minutes.ago)
                                           }

  def update_last_login_at
    current_user.update_attribute(:last_login_at, Time.current)
  end

  private

  def require_login
    redirect_to session_login_url unless signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :user_signed_in?
end
