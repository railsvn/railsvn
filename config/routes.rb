Railsvn::Application.routes.draw do
  constraints(:subdomain => /www/) do
    root :to => "homes#homepage"

    resources :articles, :shallow => true do
      collection do
        get :all
      end
      resources :comments, :except => [ :index, :show ]
    end
    match '/:year/:month/:id' => 'articles#show', :friendly => true, :constraints => { :year => /\d{4}/, :month => /\d{2}/ }

    devise_for :users, :controllers => { :sessions => 'sessions'}
  end

  match "/", :to => redirect("http://www.#{APP_CONFIG[:domain]}/")
  match "/*path", :to => redirect("http://www.#{APP_CONFIG[:domain]}/%{path}")
end
