if Rails.env.production?
 	CarrierWave.configure do |config|
		config.dropbox_access_token = ENV['DROPBOX_APP_KEY']
		config.dropbox_app_secret = ENV['DROPBOX_APP_SECRET']
	end
end