require 'httparty'

module Messages
  include HTTParty

  def get_messages(page_id = nil)
    if page_id
      body = {page: page_id}
    else
      body = {}
    end
    response = self.class.get("https://www.bloc.io/api/v1/message_threads/", body: body, headers: @headers)
    @messages = JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, tokem, subject, stripped_text)
    body = {sender: sender, recipient_id: recipient_id, token: token, subject: subject, stripped_text: stripped_text}
    response = self.class.post("https://www.bloc.io/api/v1/messages", body: body, headers: @headers)
    @create = JSON.parse(response.body)
  end
end
