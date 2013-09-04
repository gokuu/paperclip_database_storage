module PaperclipDatabaseStorage
  class Attachment < ActiveRecord::Base
    belongs_to :attached, :polymorphic => true

    attr_accessible :style, :file_data, :content_type, :file_size, :attachment_name, :base64_encoded

    def self.table_name
      return 'paperclip_database_storage_attachments'
    end
  end
end