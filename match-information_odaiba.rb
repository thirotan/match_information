# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

def get_html_source(url:)
  user_agent = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36'
  charset = nil
  html = open(url, "User-Agent" => user_agent) do |f|
    charset = f.charset
    f.read
  end
end

# odaiba
puts "odaiba"
odaiba_url = ['http://www.f-daiba.com/event-detail/?manth_index=0', 'http://www.f-daiba.com/event-detail/?manth_index=1']


def parse_document_of_odaiba(doc:)
  doc.xpath('//div[@class="event_area"]').each do |node|
    puts node.css('p.game_name').inner_text
    puts node.css('div.event_day/p.event_without').inner_text
    puts node.css('div.event_time/p.event_without').inner_text
    puts node.css('div.event_level/p.event_without').inner_text
    puts node.css('div.event_detail/a')[0][:href]
  end
end

(0..1).each do |n|
  html = get_html_source(url: odaiba_url[n])
  doc = Nokogiri::HTML.parse(html, nil, nil) 
  parse_document_of_odaiba(doc: doc)
end


puts "MIFA"

# MIFA toyosu
mifa_url = 'http://labola.jp/reserve/shop/2040/menu/tournament?embed=1'

def parse_document_of_mifa(doc:)
  doc.xpath('//table').each do |node|
    puts node.css('td[contains(@style, "text-align")]/a')[0][:href]
    puts node.css('td[contains(@style, "text-align")]/a').inner_text
  end
end


html = get_html_source(url: mifa_url)
doc = Nokogiri::HTML.parse(html, nil, nil) 
parse_document_of_mifa(doc: doc)
