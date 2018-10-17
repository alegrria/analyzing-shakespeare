require 'rubygems'
require 'nokogiri'
require 'open-uri'

class SpeechStatistics

  def self.get_xml(url)
    document = Nokogiri.parse(open(url))
    document
  end

  def self.get_tag(tag, doc)
    @speech = doc.xpath(tag)
  end

  def self.parse_speech(speech)
    @speakers_lines = []
    speech.each do |item|
      @speakers_lines << {(item.element_children.first.inner_html) => (item.element_children.length - 1).to_s}
    end
    @speakers_lines
  end

  def self.speakers_lines_count(speakers_lines)
    count = speakers_lines.reduce({}) do |speakers, lines|
      speakers.merge(lines) { |_, a, b| a.to_i + b.to_i }
    end
    count.each do |speaker|
      if speaker[0] != 'ALL'
        puts speaker[1].to_s + ' ' + speaker[0].to_s.downcase.split.map(&:capitalize).join(' ')
      end
    end
  end

end

SpeechStatistics.speakers_lines_count(SpeechStatistics.parse_speech(SpeechStatistics.get_tag('//speech', SpeechStatistics.get_xml('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'))))