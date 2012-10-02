#require 'paperclip_database/storage.rb'
require 'paperclip_database_storage'
require 'paperclip_database_storage/storage/database'
require 'rails'
require 'paperclip'

# This will load the necessary models and controllers
module PaperclipDatabaseStorage
  class Engine < Rails::Engine
  end
end