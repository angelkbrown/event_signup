# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_convocation_session',
  :secret      => '4a792ba639296b61f0dd6fc9ab01aef059c579bf928b3268fbfcf9ca50a41111665086a54bf884805a7006f0cb4b18d8a79c15297bd11acfdb85d13a6b601841'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
