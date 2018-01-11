require 'date'
require 'uri'
require 'yaml'

public_url_base = "http://podcast.ason.as"

date_format = '%a, %d %b %Y %H:%M:%S %z'

class Program
  attr_accessor :episodes
  def initilize(config)
    @title = config[:title]
    @description = config[:description]
    @icon_path = config[:icon_path]
    @xml_filename = config[:xml_filename]
    @episodes = []

    build_episodes
  end

  def files
    Dir.glob("/home/asonas/app/radiko/public/mp3/#{title}").reverse
  end

  def build_episodes
    files.each do |file|
      item_size_in_bytes = File.size(file).to_s
      publishing_date = File.mtime(file).strftime(date_format)
      url = "#{public_url_base}/mp3/#{URI.encode_www_form_component(File.basename(file)).gsub("+", "%20")}"

      content = <<-XML
        <item>
          <title>#{@title}</title>
          <description>#{@description}</description>
          <itunes:author>asonas</itunes:author>
          <itunes:subtitle>#{@title}</itunes:subtitle>
          <itunes:summary>#{@title}</itunes:summary>
          <enclosure url="#{item_url}" length="#{item_size_in_bytes}" type="audio/mpeg" />
          <pubDate>#{publishing_date}</pubDate>
          <itunes:explicit>no</itunes:explicit>
        </item>
      XML

      episodes << content
    end

    episodes
  end

  def render
    content = <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
      <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:media="http://search.yahoo.com/mrss/" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <channel>
          <title>#{@title}</title>
          <description>#{@description}</description>
          <pubDate>#{publishing_date}</pubDate>
          <media:thumbnail url="#{public_url_base}/#{}" />
          #{items_content}
        </channel>
      </rss>
    XML

    File.new("/home/asonas/app/radiko/public/#{@xml_filename}", 'w') do |fp|
      fp.write(content)
    end
  end
end

YAML.load_file("programs.yml").each do |config|
  config = Program.new(config)
  config.render
end
