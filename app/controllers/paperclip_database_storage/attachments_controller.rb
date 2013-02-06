class PaperclipDatabaseStorage::AttachmentsController < ApplicationController
  def get_attachment
    conditions = {}
    conditions[:attached_type] = params[:class].singularize.camelize(:upper) if params[:class]
    conditions[:attached_id] = params[:id] if params[:id]
    conditions[:attached_id] ||= params[:id_partition].gsub(/\//, '').to_i if params[:id_partition]
    conditions[:attachment_name] = params[:attachment].singularize if params[:attachment]
    conditions[:style] = params[:style] if params[:style]

    attachments = PaperclipDatabaseStorage::Attachment.where(conditions)

    raise ActionController::RoutingError.new('Image not Found') if attachments.empty?
    raise ActionController::RoutingError.new('Too many images found. Check your route definition') if attachments.length > 1

    attachment = attachments.first

    original_filename = attachment.attached.send(attachment.attached.attachment_definitions.select { |k, v| v[:storage] == :database }.keys.first).original_filename
    original_extension = File.extname(original_filename)
    filename = params[:filename] || original_filename
    filename = "#{filename}#{original_extension}" unless filename =~ /#{original_extension}$/

    send_data attachment.file_data,
      :type => attachment.content_type,
      :disposition => (attachment.content_type.strip =~ /^image/ ? 'inline' : 'attachment'),
      :filename => filename
  end
end
