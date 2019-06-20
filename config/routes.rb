Rails.application.routes.draw do

   devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  resources :shops, only: [:new, :edit]
  resources :reservations, only: [:index, :new, :show, :edit, :create, :destroy]
  resources :admins, only: [:index, :update, :destroy]
  resources :menus, only: [:index, :edit,:create, :update, :delete]
  root 'menus#top'
  get 'reservations/done' => "reservation#done", as: "reservation_done"
  get 'menus/top' => "menus#top", as: "top"
  get 'menus/course' => "menus#course", as: "course"
  post 'menus/course' => "menus#create", as: "course_new"
  get 'menus/access' => "menus#access", as: "access"
  get 'menus/note' => "menus#note", as: "note"
  get 'menus/add' => "menus#add", as: "add_menu"
  get '/menus/:id/edit_menu' => "menus#edit_menu", as: "renew_menu"
  patch '/menus/:id/edit_menu' => "menus#update_menu"
  delete '/menus/:id/destroy_menu' => "menus#destroy_menu"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
