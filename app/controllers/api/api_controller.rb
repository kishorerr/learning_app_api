class Api::ApiController < ActionController::Base
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    before_action :doorkeeper_authorize!

    def current_user
        token = request.headers['Authorization'].presence
        if token
         @current_user ||= Student.find_by(id: doorkeeper_token[:resource_owner_id])    
        end
    end

   def authenticate_with_token!
        render json: { errors: "Not authenticated"}, status: :unauthorized 
        unless current_user.present?
            end

        def not_found
      render json: {errors: 'Not found' }, status: 404
        end
   end
end
