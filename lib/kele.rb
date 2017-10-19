require 'httparty'
# require 'json'

class Kele
  include HTTParty
  # @base_uri = 'https://www.bloc.io/api/v1/'

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {email: email, password: password})
    @auth_token = response["auth_token"]
    @headers = {"authorization": @auth_token}
  end

  def get_me
    response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: @headers)
    @user = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: @headers)
    @mentor_availability = JSON.parse(response.body)
  end

  # private
  #
  # def api_url(endpoint)
  #   "https://www.bloc.io/api/v1/#{endpoint}"
  # end

end
