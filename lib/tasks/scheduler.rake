desc 'schedule all meetings for the week'
task schedule_meetings: :environment do
  if Time.now.friday?
    puts 'Scheduling meetings...'
    Meeting.schedule_all
    puts 'Done Scheduling meetings.'
  end
end

desc "mail all followup emails for the past week's meetings"
task trigger_followup_email: :environment do
  if Time.now.saturday?
    puts 'Sending weekly followup email...'
    Meeting.trigger_followup_email
    puts 'Done sending weekly followup email...'
  end
end

desc 'mail admin informational email'
task send_weekly_admin_email: :environment do
  if Time.now.saturday? && ENV['ADMIN_EMAIL']
    puts 'Sending weekly admin email...'
    AdminMailer.weekly.deliver
    puts 'Done sending weekly admin email...'
  end
end

desc 'mail all meetings for the week to meeting members'
task trigger_weekly_email: :environment do
  if Time.now.sunday?
    puts 'Sending weekly email...'
    Meeting.trigger_weekly_email
    puts 'Done sending weekly email...'
  end
end

desc 'truncate the db to just a year of data so that it fits 10k rows'
task trigger_db_truncation: :environment do
  meetings = "delete from meetings where created_at < CURRENT_DATE - INTERVAL '365 day';"
  meeting_members = "delete from meeting_members where created_at < CURRENT_DATE - INTERVAL '365 day';"

  ActiveRecord::Base.connection.exec_query(meetings)
  ActiveRecord::Base.connection.exec_query(meeting_members)
end
