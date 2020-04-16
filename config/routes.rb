# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :blog do
    concern :paginatable do
      get '(page/:page)', action: :index, on: :collection, as: ''
    end

    constraints subdomain: "blog" do
      resources :blog_pages, param: :slug, only: [:show]
      resources :posts, param: :slug, only: %i[index show], concerns: :paginatable
      get "posts-search", to: "posts#search"
    end
  end

  root "blog/posts#index"
end
