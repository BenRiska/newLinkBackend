Rails.application.routes.draw do
  post "message", to: "users#message"
  get "chats/:id", to: "users#chats"
  post "conversation", to: "users#conversation"
  get "/filter/:id", to: "users#filter"
  post "filter", to: "users#postfilter"
  post "/language", to: "users#language"
  post "/language/remove", to: "users#removelanguage"
  post "/login", to: "users#login" 
  resources :messages
  resources :chatlinks
  resources :langlinks
  resources :languages
  resources :conversations
  resources :users
end
