Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    post 'upload_image' => 'handwriting_recognition#upload'
    get 'list' => 'handwriting_recognition#index'
  end
end
