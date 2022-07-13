Rails.application.routes.draw do
  use_doorkeeper
  
 
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  
  
  devise_for :students
  namespace:api do
    namespace:v1 do
      namespace:meta do
        resources :boards do
          resources :s_classes
        end
        resources :s_classes do
          resources :subjects
        end
        resources :subjects do
          resources :chapters
        end
        resources :chapters do
          resources :contents
          resources :exercises
        end
        resources :exercises do
          resources :questions
        end
        resources :questions do
          resources :options
        end
      end
      namespace:user_management do
        namespace:student do
          get "/student_enrolls", to: "student_enrolls#index"
          put "/student_enrolls", to: "student_enrolls#update"
          namespace:exercise_management do
            get "/:exercise_id/attempts", to: "attempts#index"
            get "/:exercise_id/attempts/:attempt_id", to: "attempts#show"
            post "/attempt_create", to: "attempts#create"
            put "/attempt_end", to: "attempts#update"
            post "/qn_response", to: "qn_responses#create"
          end
          namespace:content_management do
            post "/upvote", to: "user_contents#upvote"
            post "/downvote", to: "user_contents#downvote"
            post "/notes", to: "user_contents#notes"
            post "/status", to: "user_contents#status"
            get "/contents/:content_id", to: "user_contents#content_details"
          end
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
        

end
