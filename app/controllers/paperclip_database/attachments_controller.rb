class PaperclipDatabase::AttachmentsController < ApplicationController
  def get_attachment
    conditions = {}
    conditions[:attached_type] = params[:class] if params[:class]
    conditions[:attached_id] = params[:id] if params[:id]
    conditions[:attached_id] ||= params[:id_partition].gsub(/\//, '').to_i if params[:id_partition]
    conditions[:attachment_name] = params[:attachment] if params[:attachment]
    conditions[:style] = params[:style] if params[:style]
    

    attachments = PaperclipDatabase::Attachment.where(conditions)

    raise ActionController::RoutingError.new('Image not Found') if attachments.empty?
    raise ActionController::RoutingError.new('Too many images found. Check your route definition') if attachments.length > 1

    attachment = attachments.first
    send_data attachment.file_data, :type => attachment.content_type
  end
end
