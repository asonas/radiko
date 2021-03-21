require 'fileutils'
require 'date'
channel = ENV["CHANNEL"]

start_datetime = ENV["START_DATETIME"] # 2020年１月１日8時0分0秒 -> 20210101080000
recording_start_time = ENV["RECORDING_START_TIME"] # 08:00:00 -> 080000

radio_title = ENV["RADIO_TITLE"]
current_dir = `pwd`.strip

start_time = if start_datetime
  start_datetime
else
  execute_date = Time.now
  recording_date = execute_date.strftime("%Y%m%d")
  recording_date + recording_start_time
end
parsed_start_time = Time.new start_time[0..3], start_time[4..5], start_time[6..7], start_time[8..9], start_time[10..11], start_time[12..13]

puts parsed_start_time
puts "docker run -it -v #{current_dir}/output:/output yyoshiki41/radigo rec -id=#{channel} -s=#{start_time}"

target_dir = "/home/asonas/app/radiko/public/mp3"

filename = "#{radio_title}-#{parsed_start_time.strftime('%Y年%m月%d日')}.mp3"

FileUtils.mv "output/*", target_dir + filename

system "ruby ./podcast.rb"
