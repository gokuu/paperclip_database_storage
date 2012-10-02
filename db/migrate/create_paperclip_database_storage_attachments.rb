class CreatePaperclipDatabaseStorageAttachments < ActiveRecord::Migration
  def self.up
     create_table :paperclip_database_storage_attachments do |t|
      t.string :attached_type, :null => false
      t.integer :attached_id, :null => false
      t.string :attachment_name, :null => false
      t.string :style, :null => false
      t.binary :file_data, :null => false
      t.string :content_type
      t.integer :file_size
      t.timestamps
    end
    add_index :paperclip_database_storage_attachments, [ :attached_type, :attached_id, :attachment_name, :style ], :unique => true, :name => :idx_attachments_1
    add_index :paperclip_database_storage_attachments, [ :attached_type, :attached_id, :attachment_name ], :name => :idx_attachments_2
    add_index :paperclip_database_storage_attachments, [ :attached_type, :attached_id ], :name => :idx_attachments_3
    add_index :paperclip_database_storage_attachments, [ :attached_type ], :name => :idx_attachments_4
    add_index :paperclip_database_storage_attachments, [ :attached_type, :attached_id, :style ], :name => :idx_attachments_5
    add_index :paperclip_database_storage_attachments, [ :attached_type, :style ], :name => :idx_attachments_6
    add_index :paperclip_database_storage_attachments, [ :style ], :name => :idx_attachments_7
    add_index :paperclip_database_storage_attachments, [ :attached_type, :attachment_name, :style ], :name => :idx_attachments_8
    add_index :paperclip_database_storage_attachments, [ :attachment_name, :style ], :name => :idx_attachments_9
    add_index :paperclip_database_storage_attachments, [ :attachment_name ], :name => :idx_attachments_10
    add_index :paperclip_database_storage_attachments, [ :attached_type, :attachment_name, :style ], :name => :idx_attachments_11
    add_index :paperclip_database_storage_attachments, [ :attachment_name, :style ], :name => :idx_attachments_12
    add_index :paperclip_database_storage_attachments, [ :style ], :name => :idx_attachments_13
  end

  def self.down
    drop_table :paperclip_database_storage_attachments
  end
end
