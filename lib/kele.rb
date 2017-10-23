require 'httparty'
require './lib/roadmap'
require './lib/messages'
#require 'json'

class Kele
  include HTTParty
  include Roadmap
  include Messages
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

  # def get_messages(page_id = nil)
  #   if page_id
  #     body = {page: page_id}
  #   else
  #     body = {}
  #   end
  #   response = self.class.get("https://www.bloc.io/api/v1/message_threads/", body: body, headers: @headers)
  #   @messages = JSON.parse(response.body)
  # end
  #
  # def create_message(sender, recipient_id, tokem, subject, stripped_text)
  #   body = {sender: sender, recipient_id: recipient_id, token: token, subject: subject, stripped_text: stripped_text}
  #   response = self.class.post("https://www.bloc.io/api/v1/messages", body: body, headers: @headers)
  #   @create = JSON.parse(response.body)
  # end

  # def get_roadmap(roadmap_id)
  #   response = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{roadmap_id}", headers: @headers)
  #   @roadmap_track = JSON.parse(response.body)
  # end
  #
  # def get_checkpoint(checkpoint_id)
  #   response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}", headers: @headers)
  #   @checkpoint_track = JSON.parse(response.body)
  # end

  # private
  #
  # def api_url(endpoint)
  #   "https://www.bloc.io/api/v1/#{endpoint}"
  # end

end
