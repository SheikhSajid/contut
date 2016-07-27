Rails.application.routes.draw do
  devise_for :students, controllers: { registrations: 'students/registrations' }
  devise_for :tutors, controllers: { registrations: 'tutors/registrations' }
  
  root    'pages#home'
  get     'about'     => 'pages#about'
  get     'contact'   => 'pages#contact'
  get     'search'    => 'pages#search'
  get     'messages'  => 'messages#mymessages'
  get     'feed'      => 'messages#feed'
  post    'request'   => 'requests#create_request'
  get     'accept'    => 'requests#accept_request'
  get     'request'   => 'requests#my_students'
  delete  'request'   => 'requests#destroy'

  # Authentication
  # get     'login'     => 'sessions#new'
  # post    'login'     => 'sessions#create'
  # delete  'logout'    => 'sessions#destroy'
  
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
  
  

end
