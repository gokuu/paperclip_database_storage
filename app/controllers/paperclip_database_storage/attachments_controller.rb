class PaperclipDatabaseStorage::AttachmentsController < ApplicationController
  def get_attachment
    conditions = {}
    conditions[:attached_type] = params[:class].singularize.camelize if params[:class]
    conditions[:attached_id] = params[:id] if params[:id]
    conditions[:attached_id] ||= params[:id_partition].gsub(/\//, '').to_i if params[:id_partition]
    conditions[:attachment_name] = params[:attachment].singularize if params[:attachment]
    conditions[:style] = params[:style] if params[:style]
    

    attachments = PaperclipDatabaseStorage::Attachment.where(conditions)

    raise ActionController::RoutingError.new('Image not Found') if attachments.empty?
    raise ActionController::RoutingError.new('Too many images found. Check your route definition') if attachments.length > 1

    attachment = attachments.first
    send_data attachment.file_data, :type => attachment.content_type, :disposition => attachment.content_type.strip =~ /^image/ ? 'inline' : 'attachment'
  end
end
