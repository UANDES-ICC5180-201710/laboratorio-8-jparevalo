Rails.application.routes.draw do
  devise_for :people, path: 'auth'
  devise_scope :person do
    get 'auth', to: 'devise/registrations#new'
  end
  authenticate :person do
    resources :courses do
      get "enrollments/enroll_existing" => 'enrollments#enroll_existing', :as => :enroll_existing
      get "enrollments/enroll_new" => 'enrollments#enroll_new', :as => :enroll_new
      resources :enrollments
      resources :assignments do
        resources :grades
      end
      get 'students', to: 'courses#students', on: :member
    end
    resources :people
    root to: 'courses#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
