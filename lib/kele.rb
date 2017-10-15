require 'httparty'

class Kele
  include HTTParty
  # @base_uri = 'https://www.bloc.io/api/v1/'

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {email: email, password: password})
    @auth_token = response["auth_token"]
  end

  def get_me
    headers = {"authorization": @auth_token}
    response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: headers)
    @user = JSON.parse(response.body)
  end

end
