Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/webhook', to: 'bot#get_webhook'
  post '/webhook', to: 'bot#post_webhook'
end
