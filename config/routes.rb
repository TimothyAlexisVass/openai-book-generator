Rails.application.routes.draw do
  post '/gpt', to: 'chat_gpt#gpt'
end
