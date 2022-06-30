class Api::V1::UserManagement::Student::Auth::RegistrationsController < Api::ApiController
    respond_to :json
    skip_before_action :verify_authenticity_token
    skip_before_action :doorkeeper_authorize!, only: %i[create]
    before_action :check_user, only: [:create]

   def create
       if params[:user][:username].blank? || params[:user][:email].blank? || params[:user][:password].blank? || params[:user][:password_confirmation].blank? || params[:user][:ph_no].blank?
            render json: {status: "failed", message: "Missing parameters"}
       else
            @student = Student.new(user_params)
            if @student.save
               @student.create_student_enroll!(otp: "1234", otp_generated_at: DateTime.now) 
                  render json: {status: "successful", user: { id: @student.id, email: @student.email, created_at: @student.created_at, updated_at: @student.updated_at }}
            else
                  render json: {status: "failed", user: @student.errors}
            end
       end
   end

   def verify_otp
     if (current_user.student_enroll.otp == params[:otp])
          render json: {status: "otp verification successful"}
     else
          render json: {status: "otp verification unsuccessful"}, status: :unauthorized
     end
   end

   def update
     current_user.update_column(:ph_no, params[:ph_no])
     render json: {status: "phone number changed successfully", ph_no: current_user.ph_no}, status: :ok
   end
   

   
   private
   
   def user_params
          params.require(:user).permit(:username,:ph_no,:dob,:email,:password,:password_confirmation)
   end

   def check_user
        if Student.exists?(email: params[:user][:email])
             render  json: {status: "failed", message: "User already exists"}, status: :unprocessable_entity
        end
   end

   def check_user_otp
     unless current_user.present?
       render json: {status: "Failed", message: "Authentication token is not valid"}, status: :unauthorized
     end
   end

   
   
end