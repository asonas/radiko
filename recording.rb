require 'fileutils'

channel = ENV["CHANNEL"]
record_time = ENV["RECORD_TIME"]
radio_title = ENV["RADIO_TITLE"]

execute_date = Time.now
record_date = execute_date.strftime("%Y%m%d")
second = "00"
completly_record_time = record_date + record_time + second

system "CHANNEL=#{channel} START_TIME=#{completly_record_time} ./recording.sh"

target_dir = "/home/asonas/app/radiko/public/mp3"

filename = "#{radio_title}-#{execute_date.strftime('%Y年%m月%d日')}.mp3"

FileUtils.mv "output/*", target_dir + filename

system "s"
