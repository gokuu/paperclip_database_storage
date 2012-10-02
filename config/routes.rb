Rails.application.routes.draw do
  # Dynamically create routes based on defined attachments
  Rails.application.eager_load!

  loaded_url_templates = []
  must_create_default_route = false

  Paperclip.classes_with_attachments.each do |class_name|
    klass = class_name.constantize

    klass.attachment_definitions.each do |attachment_name, definition|
      must_create_default_route = true and next unless definition.has_key?(:url)
      next if loaded_url_templates.include?(definition[:url])

      loaded_url_templates << definition[:url]

      #ap [klass.name, attachment_name, definition]
      get definition[:url] => 'paperclip_database/attachments#get_attachment'
    end
  end

  # Generate the default route, if necessary
  if must_create_default_route
    get Paperclip::Attachment.default_options[:url] => 'paperclip_database/attachments#get_attachment'
  end
end
