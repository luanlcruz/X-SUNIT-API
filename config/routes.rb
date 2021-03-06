Rails.application.routes.draw do
  
  # Statistics routes.
  get 'survivors/abducted_survivors'
  get 'survivors/non_abducted_survivors'
  get 'survivors/abducted_percentage'
  

  # Denunciations routes.
  resources :denunciations, only: [:index, :show, :create] do
    resource :survivor, only: [:index, :show]
  end

  # Survivors routes.
  resources :survivors, only: [:index, :show, :create, :update] do
    resource :location, only: [:index, :show]
    resource :denunciations, only: [:show]
  end
end
