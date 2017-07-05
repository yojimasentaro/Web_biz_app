class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :info, :warning, :danger

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(
        :username,
        :member,
        :profile,
        :works,
        :avatar
        )
      devise_parameter_sanitizer.for(:account_update).push(
        :username,
        :avatar,
        :member,
        :profile,
        :works
        )
    end
end
