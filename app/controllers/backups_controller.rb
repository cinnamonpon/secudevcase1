class BackupsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @files = Backup.all
  end

  def create
    file = "#{Rails.root}/private/backup-#{Time.now}.csv"
    @backup = Backup.new(filename: file.partition('private/').last)

    if @backup.save
      posts = Post.all
      CSV.open( file, 'w' ) do |writer|
        posts.each do |p|
          writer << [p.user.username, p.created_at, p.content]
        end
      end
      flash[:success] = "Backup successfully created."
      redirect_to backups_path
    else
      flash[:danger] = "Backup creation failed."
      render 'index'
    end
  end

  def download
    backup = Backup.find(params[:backup_id])

    filepath = "#{Rails.root}/private/#{backup.filename}"
    if File.exist?(path = filepath)
      send_file path, :content_type => "application/csv", :x_sendfile => true
    else
      flash[:danger] = "File not found."
    end
  end
  
end
