class GptController < ApplicationController
  include GptRequestable

  def gpt
    model ||= params[:model] || "gpt-3.5-turbo"
    temperature ||= params[:temperature] || 0.7

    system_message = params[:system_message] if params.has_key?(:system_message)
    user_message = params[:user_message]

    paragraphs = send_gpt_request(system_message, user_message, model, temperature)

    render json: { message: paragraphs }
  end
end
