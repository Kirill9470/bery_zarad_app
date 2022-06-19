Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        member do
          put :change_balance
        end
      end

      resources :transactions, only: :index
    end
  end
end
