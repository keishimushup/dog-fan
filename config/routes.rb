Rails.application.routes.draw do

  #ユーザー側
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
  }

  #管理者側
  devise_for :admin,skip: [:passwords], controllers: {
  sessions: "admin/sessions",
  registrations: "admin/registrations"
  }

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
    resources :users, only: [:show]
  end
end
