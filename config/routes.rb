Rails.application.routes.draw do
  scope module: :user do
    root to: "homes#top"
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end
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

end
