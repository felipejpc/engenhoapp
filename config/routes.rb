Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints subdomain: 'blog' do
    resources :pages, param: :slug, only: [:show]
    resources :posts, param: :slug, only: [:index, :show]
  end
  root 'posts#index'
end
