Rails.application.routes.draw do

  #ユーザー側
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
  }
  #ゲストログイン
  devise_scope :user do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  #管理者側
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  #ゲストログイン
  devise_scope :admin do
    post 'admin/guest_sign_in', to: 'admin/sessions#guest_sign_in'
  end

  scope module: :user do
    root to: "homes#top"
    get "search" => "searches#search"
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:show, :destroy]
    get "/users/confilm/:id" => "users#confilm"
  end
end
