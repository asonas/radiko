require 'date'
require 'uri'
# Config values
podcast_title = "asoradi"
podcast_description = "internal podcast"
public_url_base = "http://podcast.ason.as"


# Generated values
date_format = '%a, %d %b %Y %H:%M:%S %z'
podcast_pub_date = DateTime.now.strftime(date_format)

# Build the items
items_content = ""
Dir.glob('/home/asonas/app/radiko/public/mp3/*').reverse.each do |file|
  next if file =~ /^\./  # ignore invisible files
  next unless file =~ /\.(mp3|m4a)$/  # only use audio files

  item_size_in_bytes = File.size(file).to_s
  item_pub_date = File.mtime(file).strftime(date_format)
  item_title = File.basename(file).gsub(File.extname(file), "")
  item_subtitle = item_title
  item_summary = item_title
  item_url = "#{public_url_base}/mp3/#{URI.encode_www_form_component(File.basename(file)).gsub("+", "%20")}"
  #item_url = "#{public_url_base}/mp3/#{File.basename(file).gsub(" ", "%20")}"
  item_content = <<-HTML
      <item>
        <title>#{item_title}</title>
        <description>description</description>
        <itunes:author>asonas</itunes:author>
        <itunes:subtitle>#{item_subtitle}</itunes:subtitle>
        <itunes:summary>#{item_summary}</itunes:summary>
        <enclosure url="#{item_url}" length="#{item_size_in_bytes}" type="audio/mpeg" />
        <pubDate>#{item_pub_date}</pubDate>
        <itunes:explicit>no</itunes:explicit>
      </item>
HTML

    items_content << item_content
end

# Build the whole file
content = <<-HTML
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:media="http://search.yahoo.com/mrss/" xmlns:dc="http://purl.org/dc/elements/1.1/">
    <channel>
        <title>#{podcast_title}</title>
        <description>#{podcast_description}</description>
        <pubDate>#{podcast_pub_date}</pubDate>
#{items_content}
    </channel>
</rss>
HTML

# write it out
output_file = File.new("/home/asonas/app/radiko/public/podcast.rss", 'w')
output_file.write(content)
output_file.close
