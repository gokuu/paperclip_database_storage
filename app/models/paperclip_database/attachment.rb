module PaperclipDatabase
  class Attachment < ActiveRecord::Base
    belongs_to :attached, :polymorphic => true
    
    attr_accessible :style, :file_data, :content_type, :file_size, :attachment_name

    def self.table_name
      return 'paperclip_database_attachments'
    end
  end
end