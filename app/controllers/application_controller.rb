class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:account, :profile_picture])
        devise_parameter_sanitizer.permit(:account_update, keys: [:account, :profile_picture])
    end
end
