# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_microblog_session',
  :secret      => 'ce2272052058bf9ec013fcfbbb6e762baa9c9fcef6e471ba1d950b6c483aaec9e8eb15b25f427806a71628a00aa6d29b7347fdabec62e0041a45721864ec3a67'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
