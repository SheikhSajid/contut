Rails.application.routes.draw do
  get 'admins/new'

  devise_for :students, controllers: { registrations: 'students/registrations' }
  devise_for :tutors, controllers: { registrations: 'tutors/registrations' }
  
  root    'pages#home'
  get     'about'     => 'pages#about'
  get     'contact'   => 'pages#contact'
  get     'search'    => 'pages#search'
  get     'messages'  => 'messages#mymessages'
  get     'feed'      => 'messages#feed'
  
  # Requests
  post    'request'   => 'requests#create_request'
  get     'accept'    => 'requests#accept_request'
  get     'request'   => 'requests#my_requests'
  delete  'request'   => 'requests#destroy'

  # Admin Authentication
  get     'admin_login'     => 'sessions#new'
  post    'admin_login'     => 'sessions#create'
  delete  'admin_logout'    => 'sessions#destroy'
  
  # Filters
  get     'filter_by_subject' => 'pages#filter'
  get     'filtered_results'  => 'pages#filtered_results'
  
  # Entities
  resources :tutors, only: [:index, :show] do
    resources :reviews, except: [:show, :index]
  end
  resources :students, only: [:show]
  resources :subjects
  resources :messages, except: [:show, :index]
  
  resources :articles
  
  resources :certificates, except: [:destroy]
  get 'approve_certificate' => 'certificates#approve'
  get 'decline_certificate' => 'certificates#decline'

end
