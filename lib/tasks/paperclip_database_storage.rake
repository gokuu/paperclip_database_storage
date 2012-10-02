namespace :'paperclip_database_storage' do
  desc 'Copy necessary migrations from paperclip_database_storage to the rails project'
  task :setup => :environment do
    plugin_root = File.dirname(File.dirname(File.dirname(__FILE__)))

    Dir[File.join(plugin_root, 'db', 'migrate', '*.rb')].each do |file|
      # First, check if the migration has already been copied
      if Dir[File.join('db', 'migrate', "*#{File.basename(file)}*")].any?
        puts "Migration #{File.basename(file)} has already been copied, skipping..."
      else
        dest_file = "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{File.basename(file)}"
        dest_dir = File.join(Rails.root, 'db', 'migrate')
        
        puts "Copying #{File.basename(file)} to #{dest_file}"

        FileUtils.mkdir_p dest_dir
        FileUtils.cp(file, File.join(dest_dir, dest_file))        
      end
    end
  end
end
