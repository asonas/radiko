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
  command "CHANNEL=TBS RECORD_TIME=010000 RADIO_TITLE=JUNK伊集院光と深夜の馬鹿力 /usr/bin/env ruby recording.rb"
end

every '0 1 * * 0'  do
  command "CHANNEL=QRP RECORD_TIME=000000 RADIO_TITLE=上坂すみれの♡（はーと）をつければかわいかろう /usr/bin/env ruby recording.rb"
end

every '30 12 * * 1-5'  do
  command "CHANNEL=TBS RECORD_TIME=083000 RADIO_TITLE=伊集院光とらじおと /usr/bin/env ruby recording.rb"
end
