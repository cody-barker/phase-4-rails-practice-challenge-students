Rails.application.routes.draw do
  #nesting route for student creation within an instructor.
  #can update a student via student path after creation
  resources :instructors do
    resources :students
  end

  resources :students, only: [:index, :show, :destroy]
  
end
