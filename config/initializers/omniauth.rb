Rails.application.config.middleware.use OmniAuth::Builder do 
	provider :facebook, '182384698969016', '8d183461584b162886fe1cdee0125a5c', image_size: 'large'
	provider :github, '10afe6d2728eddcb84cd', '9b53e91c1d287dc0216f6e1345d4326a922547d1'
end