class ChatGptController < ApplicationController
  def gpt
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: params[:user_message] }],
        temperature: 0.7
      }
    )

    chat_response = response.dig("choices", 0, "message", "content")

    render json: { message: chat_response }
  end
end
