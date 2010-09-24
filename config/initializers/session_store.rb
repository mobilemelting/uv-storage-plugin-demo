# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_uv_storage_plugin_session',
  :secret      => 'ab5a68d9e23f8ec7ad2b95d67c40e6ab73c91e80e92f9217abcbc622099e14ff7af9a702a441725ea128d346dff17a0bf6c954335350c977728d8d176cf37ec6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
