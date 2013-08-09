module Spree
  module Admin
    class AuthenticationMethodsController < ResourceController
      create.after :update_oauth_method
      update.after :update_oauth_method

      private

      def update_oauth_method
        auth_method = params[:authentication_method]
        if auth_method[:active] == "true" && auth_method[:environment] == ::Rails.env
          SpreeSocial.setup_key_for(:provider, auth_method[:api_key], auth_method[:api_secret], auth_method[:scope])
        end
      end
    end
  end
end
