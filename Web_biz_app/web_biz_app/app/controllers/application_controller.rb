class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :info, :warning, :danger

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys:[
        :username,
        :member,
        :profile,
        :works,
        :avatar
        ])

      devise_parameter_sanitizer.permit(:account_update, keys: [
        :username,
        :avatar,
        :member,
        :profile,
        :works
        ])
    end
end
