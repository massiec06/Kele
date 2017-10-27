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

  def create_message(recipient_id, stripped_text, subject=nil, token=nil)
    body = {"sender": user["email"], "recipient_id": recipient_id, "stripped-text": stripped_text}
    body.merge!({"token": token}) if token
    body.merge!({"subject": subject}) if subject
    puts body.inspect
    response = self.class.post("https://www.bloc.io/api/v1/messages", body: body, headers: @headers)
    @test = response
    if response.success?
      "Message Sent"
    else
      response["message"]
    end
  end
end
