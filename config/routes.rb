ImageHud::Application.routes.draw do
  get "images/index"
  post "images/index"
  
  match 'images/data/:id' => 'images#data'
  root :to => "images#index"
end
