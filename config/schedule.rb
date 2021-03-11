# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "/home/asonas/app/radiko/log/cron.log"
job_type :command, "cd :path && ':task' :output"

every '0 3 * * 2'  do
  command "CHANNEL=TBS RECORD_TIME=0100 RADIO_TITLE=JUNK伊集院光と深夜の馬鹿力 ruby recording.rb"
end

every '0 1 * * 0'  do
  command "CHANNEL=QRR RECORD_TIME=0000 RADIO_TITLE=上坂すみれの♡（はーと）をつければかわいかろう ruby recording.rb"
end

every '30 12 * * 1-5'  do
  command "CHANNEL=TBS RECORD_TIME=0830 RADIO_TITLE=伊集院光とらじおと ruby recording.rb"
end
