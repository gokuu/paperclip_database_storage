#require 'paperclip_database/storage.rb'
require 'paperclip_database'
require 'paperclip_database/storage/database'
require 'rails'
require 'paperclip'

# This will load the necessary models and controllers
module PaperclipDatabase
  class Engine < Rails::Engine
  end
end