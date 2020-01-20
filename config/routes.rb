Rails.application.routes.draw do

  get 'courses/index'
  # resources :meetings
  resources :reservations

  
  devise_for :admins, controllers: { registrations: 'registrations' }
  

  resources :shops, only: [:new, :edit]
  resources :admins, only: [:index, :update, :destroy, :new]
  resources :questions, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :admins, only: [] do
    collection do
      post :generate
    end
  end
  
  resources :menus, only: [] do
    resources :courses, only: :index
  end

  resources :menus, only: [:edit,:create, :update, :delete]
  root 'menus#top'
  get 'change/schedule' => "reservations#change_schedule", as: "change_schedule"
  get 'menus/top' => "menus#top", as: "top"
  get 'menus/course' => "menus#course", as: "course"
  post 'menus/course' => "menus#create", as: "course_new"
  get 'menus/access' => "menus#access", as: "access"
  get 'menus/note' => "menus#note", as: "note"
  get 'menus/add' => "menus#add", as: "add_menu"
  get '/menus/:id/edit_menu' => "menus#edit_menu", as: "renew_menu"
  patch '/menus/:id/edit_menu' => "menus#update_menu"
  delete '/menus/:id/edit_menu' => "menus#destroy"
  
  get 'all_reservations/index' => "reservations#all_index", as: "all_reservations_index"
  get 'all_reservations/:id/show' => "reservations#all_show", as: "all_reservations_show"


end


