class ChatGptController < ApplicationController
  def gpt
    client = OpenAI::Client.new

    model ||= params[:model] || "gpt-3.5-turbo"

    messages ||= []
    messages << { role: "system", content: params[:system_messate]} if params.has_key?(:system_messate)
    messages = [{ role: "user", content: params[:user_message]}]

    temperature ||= params[:temperature] || 0.7

    response = client.chat(
      parameters: {
        model: model,
        messages: messages,
        temperature: temperature
      }
    )

    chat_response = response.dig("choices", 0, "message", "content")

    render json: { message: chat_response }
  end
end
