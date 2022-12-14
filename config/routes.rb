# == Route Map
#
#                                Prefix Verb     URI Pattern                                  Controller#Action
#                         host_listings GET      /host/listings(.:format)                     host/listings#index
#                                       POST     /host/listings(.:format)                     host/listings#create
#                      new_host_listing GET      /host/listings/new(.:format)                 host/listings#new
#                     edit_host_listing GET      /host/listings/:id/edit(.:format)            host/listings#edit
#                          host_listing GET      /host/listings/:id(.:format)                 host/listings#show
#                                       PATCH    /host/listings/:id(.:format)                 host/listings#update
#                                       PUT      /host/listings/:id(.:format)                 host/listings#update
#                                       DELETE   /host/listings/:id(.:format)                 host/listings#destroy
#                      new_user_session GET      /users/sign_in(.:format)                     users/sessions#new
#                          user_session POST     /users/sign_in(.:format)                     users/sessions#create
#                  destroy_user_session DELETE   /users/sign_out(.:format)                    users/sessions#destroy
# user_google_oauth2_omniauth_authorize GET|POST /users/auth/google_oauth2(.:format)          users/omniauth_callbacks#passthru
#  user_google_oauth2_omniauth_callback GET|POST /users/auth/google_oauth2/callback(.:format) users/omniauth_callbacks#google_oauth2
#                     new_user_password GET      /users/password/new(.:format)                users/passwords#new
#                    edit_user_password GET      /users/password/edit(.:format)               users/passwords#edit
#                         user_password PATCH    /users/password(.:format)                    users/passwords#update
#                                       PUT      /users/password(.:format)                    users/passwords#update
#                                       POST     /users/password(.:format)                    users/passwords#create
#              cancel_user_registration GET      /users/cancel(.:format)                      users/registrations#cancel
#                 new_user_registration GET      /users/sign_up(.:format)                     users/registrations#new
#                edit_user_registration GET      /users/edit(.:format)                        users/registrations#edit
#                     user_registration PATCH    /users(.:format)                             users/registrations#update
#                                       PUT      /users(.:format)                             users/registrations#update
#                                       DELETE   /users(.:format)                             users/registrations#destroy
#                                       POST     /users(.:format)                             users/registrations#create
#                 new_user_confirmation GET      /users/confirmation/new(.:format)            users/confirmations#new
#                     user_confirmation GET      /users/confirmation(.:format)                users/confirmations#show
#                                       POST     /users/confirmation(.:format)                users/confirmations#create
#                       new_user_unlock GET      /users/unlock/new(.:format)                  users/unlocks#new
#                           user_unlock GET      /users/unlock(.:format)                      users/unlocks#show
#                                       POST     /users/unlock(.:format)                      users/unlocks#create

Rails.application.routes.draw do
  namespace :host do
    resources :listings
  end
  root "static_pages#index"
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions",
    unlocks: "users/unlocks",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
end
