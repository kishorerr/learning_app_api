class Api::V1::UserManagement::Student::Auth::SessionsController < Api::ApiController
    respond_to :json
    skip_before_action :verify_authenticity_token
    before_action :doorkeeper_authorize!, only: [:destroy]
    before_action :ensure_params_exist, only: [:create]

    def create
           resource = Student.find_for_database_authentication(email: params[:user][:email])
           return invalid_login_attempt unless resource
           if resource.valid_password?(params[:user][:password])
                 sign_in("user", resource)
                 access_token = Doorkeeper::AccessToken.create(
                  resource_owner_id: resource.id,
                  refresh_token: generate_refresh_token,
                  expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
                  scopes: ''
                )
                 render json: {status: "successful", user: { id: resource.id, email: resource.email,  auth_token: access_token.token, created_at: resource.created_at, updated_at: resource.updated_at }}
                 return
           end
           invalid_login_attempt
     end

     def destroy
           if current_user.present?
                 sign_out(current_user)
                 render json: {status: "successful", message: "Your Account Logged Out Successfully" }
           else
                 render json: {status: "failed", message: "Authentication token is not valid" }, status: :unauthorized
           end
      end

      protected

      def ensure_params_exist
             return unless params[:user].blank?
             render json: {status: "failed", message: "Missing User Parameter"}, status: :bad_request
      end

      def invalid_login_attempt
            warden.custom_failure!
            render json: {status: "failed", message: "Error with your Email or password"}, status: :unauthorized
      end

      def generate_refresh_token
            loop do
                 token = SecureRandom.hex(32)
                 break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
            end
          end
end