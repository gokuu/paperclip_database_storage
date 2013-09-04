class AddBase64EncodedToPaperclipDatabaseStorageAttachments < ActiveRecord::Migration
  def self.up
    add_column :paperclip_database_storage_attachments, :base64_encoded, :boolean, default: false
  end

  def self.down
    remove_column :paperclip_database_storage_attachments, :base64_encoded
  end
end
