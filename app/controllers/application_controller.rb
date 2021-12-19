# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorHandling
  include SessionHelper

  before_action :require_login
  before_action :update_last_login_at, if: lambda {
                                             user_signed_in? &&
                                               (current_user.last_login_at.nil? || current_user.last_login_at < 3.minutes.ago)
                                           }
  around_action :switch_locale

  def update_last_login_at
    current_user.update_attribute(:last_login_at, Time.current)
  end

  private

  def switch_locale(&action)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]
    return locale if I18n.available_locales.map(&:to_s).include?(locale)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def require_login
    redirect_to session_login_url unless signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :user_signed_in?
end
