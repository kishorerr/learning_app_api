module RequestSpecHelper
    def json
      JSON.parse(response.body)
    end

    def auth_headers(user)
      post '/api/v1/user_management/student/auth/signin', params:  { email: user.email, password: user.password } 
      return { auth: { 'Content-Type' => response.headers['Content-Type'],
        'Authorization' => "Bearer #{JSON.parse(response.body)["user"]["auth_token"]}" }
        }
    end

  end