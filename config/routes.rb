# == Route Map
#
#                                Prefix Verb     URI Pattern                                     Controller#Action
#                              listings GET      /listings(.:format)                             listings#index
#                               listing GET      /listings/:id(.:format)                         listings#show
#                          reservations GET      /reservations(.:format)                         reservations#index
#                                       POST     /reservations(.:format)                         reservations#create
#                       new_reservation GET      /reservations/new(.:format)                     reservations#new
#                      edit_reservation GET      /reservations/:id/edit(.:format)                reservations#edit
#                           reservation GET      /reservations/:id(.:format)                     reservations#show
#                                       PATCH    /reservations/:id(.:format)                     reservations#update
#                                       PUT      /reservations/:id(.:format)                     reservations#update
#                                       DELETE   /reservations/:id(.:format)                     reservations#destroy
#                    host_listing_rooms GET      /host/listings/:listing_id/rooms(.:format)      host/rooms#index
#                                       POST     /host/listings/:listing_id/rooms(.:format)      host/rooms#create
#                     host_listing_room DELETE   /host/listings/:listing_id/rooms/:id(.:format)  host/rooms#destroy
#                   host_listing_photos GET      /host/listings/:listing_id/photos(.:format)     host/photos#index
#                                       POST     /host/listings/:listing_id/photos(.:format)     host/photos#create
#                    host_listing_photo DELETE   /host/listings/:listing_id/photos/:id(.:format) host/photos#destroy
#                         host_listings GET      /host/listings(.:format)                        host/listings#index
#                                       POST     /host/listings(.:format)                        host/listings#create
#                      new_host_listing GET      /host/listings/new(.:format)                    host/listings#new
#                     edit_host_listing GET      /host/listings/:id/edit(.:format)               host/listings#edit
#                          host_listing GET      /host/listings/:id(.:format)                    host/listings#show
#                                       PATCH    /host/listings/:id(.:format)                    host/listings#update
#                                       PUT      /host/listings/:id(.:format)                    host/listings#update
#                                       DELETE   /host/listings/:id(.:format)                    host/listings#destroy
#                      new_user_session GET      /users/sign_in(.:format)                        users/sessions#new
#                          user_session POST     /users/sign_in(.:format)                        users/sessions#create
#                  destroy_user_session DELETE   /users/sign_out(.:format)                       users/sessions#destroy
# user_google_oauth2_omniauth_authorize GET|POST /users/auth/google_oauth2(.:format)             users/omniauth_callbacks#passthru
#  user_google_oauth2_omniauth_callback GET|POST /users/auth/google_oauth2/callback(.:format)    users/omniauth_callbacks#google_oauth2
#                     new_user_password GET      /users/password/new(.:format)                   users/passwords#new
#                    edit_user_password GET      /users/password/edit(.:format)                  users/passwords#edit
#                         user_password PATCH    /users/password(.:format)                       users/passwords#update
#                                       PUT      /users/password(.:format)                       users/passwords#update
#                                       POST     /users/password(.:format)                       users/passwords#create
#              cancel_user_registration GET      /users/cancel(.:format)                         users/registrations#cancel
#                 new_user_registration GET      /users/sign_up(.:format)                        users/registrations#new
#                edit_user_registration GET      /users/edit(.:format)                           users/registrations#edit
#                     user_registration PATCH    /users(.:format)                                users/registrations#update
#                                       PUT      /users(.:format)                                users/registrations#update
#                                       DELETE   /users(.:format)                                users/registrations#destroy
#                                       POST     /users(.:format)                                users/registrations#create
#                 new_user_confirmation GET      /users/confirmation/new(.:format)               users/confirmations#new
#                     user_confirmation GET      /users/confirmation(.:format)                   users/confirmations#show
#                                       POST     /users/confirmation(.:format)                   users/confirmations#create
#                       new_user_unlock GET      /users/unlock/new(.:format)                     users/unlocks#new
#                           user_unlock GET      /users/unlock(.:format)                         users/unlocks#show
#                                       POST     /users/unlock(.:format)                         users/unlocks#create

Rails.application.routes.draw do
  root "static_pages#index"

  resources :listings, only: %i[index show]
  resources :reservations

  namespace :host do
    resources :listings do
      # /host/listings/:listing_id/rooms
      resources :rooms, only: %i[index create destroy]

      # /host/listings/:listing_id/photos
      resources :photos, only: %i[index create destroy]
    end
  end

  devise_for :users,
             controllers: {
               confirmations: "users/confirmations",
               passwords: "users/passwords",
               registrations: "users/registrations",
               sessions: "users/sessions",
               unlocks: "users/unlocks",
               omniauth_callbacks: "users/omniauth_callbacks",
             }
end
