Rails.application.routes.draw do
  #nesting route for student creation within an instructor.
  #can update a student via student path after creation
  resources :instructors do
    resources :students, only: [:index, :create]
  end

  resources :students, only: [:index, :show, :destroy, :update]
  
end
