Rails.application.routes.draw do
  root    'pages#home'
  get     'about'     => 'pages#about'
  get     'contact'   => 'pages#contact'
  get     'messages'  => 'messages#mymessages'
  get     'feed'      => 'messages#feed'

  # Authentication
  get     'login'     => 'sessions#new'
  post    'login'     => 'sessions#create'
  delete  'logout'    => 'sessions#destroy'
  
  # Filters
  get     'filter_by_subject' => 'pages#filter'
  get     'filtered_results'  => 'pages#filtered_results'
  
  # Entities
  resources :tutors do
    resources :reviews, except: [:show, :index]
  end
  resources :students, except: [:index]
  resources :subjects
  resources :messages, except: [:show]

end
