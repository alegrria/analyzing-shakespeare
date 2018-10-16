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

end

doc = SpeechStatistics.get_xml('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
speech = SpeechStatistics.get_tag('//SPEECH', doc)
speakers_lines = SpeechStatistics.parse_speech(speech)