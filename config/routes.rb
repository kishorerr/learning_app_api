Rails.application.routes.draw do
  use_doorkeeper
  
  devise_for :admins
 
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  
  
  devise_for :students
  namespace:api do
    namespace:v1 do
      resources :boards
      resources :s_classes
      resources :subjects
      namespace:user_management do
        namespace:student do
          resources :student_enrolls
          put "/student_enrolls", to: "student_enrolls#update"
          namespace:auth do
            post "/verify_otp", to: "registrations#verify_otp"
            put "/otp_num_change", to: "registrations#update"
            devise_scope :student do                                                               
              post 'signup' => 'registrations#create'                                   
              post 'signin' => 'sessions#create'                                          
              delete 'signout' => 'sessions#destroy'                              
           end
          end
        end
      end
    end
  end
        
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #  root "boards#index"
end
