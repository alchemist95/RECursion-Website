Rails.application.routes.draw do

 	mount Ckeditor::Engine => '/ckeditor'
	mount RailsAdmin::Engine => '/sapphire', as: 'rails_admin'


	root :to => 'home#index'
	get 'auth/:provider/callback', to: "sessions#create"
	delete 'sign_out', to:  "sessions#destroy", as: 'sign_out'

	get '/users/update_profile' => 'users#update_profile', as: 'profile_update'
 	post '/users/update_profile' => 'users#save_update', as: ''
    get '/users/profile/:nickname' => 'users#profile', as: 'users'
    post '/users/checknickname' => 'users#checknickname', as: ''

	get '/askrec' => 'home#forum'
	get '/getstarted' => 'home#getstarted'

	scope '/askrec' do
		resources :questions, only: [:show, :new, :create]
	end

    get '/lectures' => 'lectures#index'
  	get '/lectures/:held_on' => 'lectures#show', as: 'lecture'

	post '/askrec/questions/:id' => 'questions#submit_answer', as: 'answer'
	post '/edit_answer' => 'questions#edit_answer'

	get '/askrec/questions/:id/follow' => 'questions#follow'
	post '/askrec/questions/:id/comment' => 'questions#add_comment'

	get '/askrec/questions/tags/:tag' => 'questions#tagged_questions', as: 'tagged'

	get '/team' => 'home#team'

	post '/find_questions' => 'questions#search'

	post '/find_users' => 'users#search'

	get '/edit_tag' => 'questions#edit_tag_name'
	get '/add_tag' => 'questions#add_tag'

	post '/upvoteAnswer' => 'questions#upvote'

	resources :events, only: [:index]

end
