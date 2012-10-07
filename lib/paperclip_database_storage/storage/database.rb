module Paperclip
  module Storage
    module Database
      def self.extended(base)
        base.instance_eval do
          override_default_options base
        end
      end

      def override_default_options(base)
        @path = @url
      end

      private :override_default_options

      def exists?(style = default_style)
        return !get_attachment(style).nil?
      end

      def path(style = default_style)
        return style
      end

      def get_attachment(style)
        return PaperclipDatabaseStorage::Attachment.find(:first, :conditions => {
          :style => style, 
          :attached_type => self.instance.class.name, 
          :attached_id => self.instance.id,
          :attachment_name => self.get_attachment_definitions.keys.first
        })
      end

      def get_attachment_definitions
        attachment_definitions = self.instance.class.attachment_definitions
        
        if attachment_definitions.select { |k,v| v[:storage] == :database }.count > 1
          raise Exception.new('paperclip-database does not support more than one attachment per model')
        end

        return attachment_definitions
      end


      def to_file style = default_style
        if @queued_for_write[style]
          @queued_for_write[style]
        elsif exists?(style)
          attachment = get_attachment(style)
          tempfile = Tempfile.new attachment.base_name
        tempfile.write attachment.file_data
        tempfile
        else
          nil
        end
      end

      def flush_writes
        puts("[paperclip] Writing files #{@queued_for_write.count}")
        attachment_definitions = get_attachment_definitions

        @queued_for_write.each do |style, file|
          puts("[paperclip] Writing files for #{file} #{style}")

          PaperclipDatabaseStorage::Attachment.new do |a|
            a.attached_type = self.instance.class.name
            a.attached_id = self.instance.id
            a.style = style
            a.content_type = file.content_type
            a.attachment_name = attachment_definitions.keys.first
            a.file_size = file.size
            a.file_data = file.read
          end.save
        end
        @queued_for_write = {}
      end

      def flush_deletes
        @queued_for_delete.each do |style|
          puts("[paperclip] Deleting files for #{style}")
          attachment = get_attachment(style)
          attachment.destroy if !attachment.nil?
        end
        @queued_for_delete = []
      end
    end
  end
end