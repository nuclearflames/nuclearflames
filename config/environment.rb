# Load the rails application
require File.expand_path('../application', __FILE__)
ActionController::Base.session_options[:session_secure] = true
# Initialize the rails application
Nuclearflames::Application.initialize!

