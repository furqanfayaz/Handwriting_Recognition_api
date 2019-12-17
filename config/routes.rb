Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get 'autosuggestion' => 'ports#autosuggest'
      get 'ports_in_country'  =>  'ports#get_ports'

    end
  end
end
