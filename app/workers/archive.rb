class Archive
  @queue = :pictcollect

  def self.perform(unix_command)
    `#{unix_command} >> /tmp/album_job_queue/command`
  end
end
    
