# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_saasramp_demp_app_session',
  :secret      => '6097634e77b2de70ecb1d2e4905fd980e2aa2c9833e11de7cd4249f29fb832c6d273400537bd3c715ef084bcddf408c30eb5c225208023e30abee93545502717'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
