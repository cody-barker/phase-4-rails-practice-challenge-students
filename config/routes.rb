Rails.application.routes.draw do
  resources :instructors do
    resources :students, only: [:index, :create]
  end

  resources :students, only: [:index, :show, :destroy, :update]
  
end
