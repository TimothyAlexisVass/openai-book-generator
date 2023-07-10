module GptRequestable
  def send_gpt_request(system_message, user_message, model, temperature)
    client = OpenAI::Client.new

    messages = []
    messages << { role: "system", content: system_message } if system_message
    messages << { role: "user", content: user_message }

    response = client.chat(
      parameters: {
        model: model,
        messages: messages,
        temperature: temperature
      }
    )

    JSON.parse(response.dig("choices", 0, "message", "content"))
  end
end