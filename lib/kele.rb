require 'httparty'
require 'json'


class Kele
    include HTTParty

  def initialize(email, password)
    response = self.class.post('https://www.bloc.io/api/v1/sessions', body: { "email": email, "password": password })
    raise 'Invalid Email and/or Password' if response.code != 200
    @auth_token = response["auth_token"]
  end
  
  def get_me 
      response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @auth_token })
      @user_me = JSON.parse(response.body)
  end
end


  
  
  
