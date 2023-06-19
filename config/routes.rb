Rails.application.routes.draw do
  resources :instructors do
    resources :students, only: [:create, :update]
  end

  resources :students, only: [:index, :show, :destroy]
  
end
