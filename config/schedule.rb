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
exec_dir = "/home/asonas/app/radiko"
save_dir = "/home/asonas/app/radiko/public/mp3"

every '0 1 * * 2'  do
  command "bash #{exec_dir}/rec_radiko.sh TBS 121 #{save_dir}/JUNK伊集院光と深夜の馬鹿力-"
end

every '0 0 * * 0'  do
  command "bash #{exec_dir}/rec_radiko.sh QRR 31 #{save_dir}/上坂すみれの♡（はーと）をつければかわいかろう-"
end

every '30 8 * * 1-5'  do
  command "bash #{exec_dir}/rec_radiko.sh TBS 151 #{save_dir}/伊集院光とらじおと-"
end
