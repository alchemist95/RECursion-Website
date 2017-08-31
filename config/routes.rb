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
	get '/recblog' => 'home#blog'
	get '/getstarted' => 'home#getstarted'

	scope '/recblog' do
		resources :posts, except: [:index]
	end

	scope '/askrec' do
		resources :questions, only: [:show, :new, :create]
	end

    get '/lectures' => 'lectures#index'
  	get '/lectures/:held_on' => 'lectures#show', as: 'lecture'

	post '/askrec/questions/:id' => 'questions#submit_answer', as: 'answer'

	get '/recblog/posts/:id/like' => 'posts#like'
	get '/recblog/posts/:id/unlike' => 'posts#unlike'

	get '/askrec/questions/:id/upvote' => 'questions#upvote'
	get '/askrec/questions/:id/follow' => 'questions#follow'
	post '/askrec/questions/:id/comment' => 'questions#add_comment'

	get '/team' => 'home#team'

end
