require 'spec_helper'
require 'macbeth.rb'

describe SpeechStatistics do
  describe '.get_xml' do
    it 'should return xml' do
      xml_doc = 'Alf.xml'
      expect(SpeechStatistics.get_xml(xml_doc).at('name').text).to eq('Alf')
    end
  end

  describe '.get_tag' do
    it 'should return elements with a tag' do
      tag = '//aliens'
      doc = SpeechStatistics.get_xml('Alf.xml')
      expect(SpeechStatistics.get_tag(tag, doc).xpath(tag).length).to eq(1)
    end
  end

  describe '.parse_speech' do
    it 'should return an array of hashes with speakers and their lines' do
      tag = '//alien'
      doc = SpeechStatistics.get_xml('Alf.xml')
      speech = SpeechStatistics.get_tag(tag, doc).xpath(tag)
      expect(SpeechStatistics.parse_speech(speech)).to eq([{'Alf'=>'0'}])
    end
  end

  describe '.speakers_lines_count' do
    it 'should print count of lines and speakers\'s names' do
      tag = '//alien'
      doc = SpeechStatistics.get_xml('Alf.xml')
      speech = SpeechStatistics.get_tag(tag, doc).xpath(tag)
      speakers_lines = SpeechStatistics.parse_speech(speech)
      expect(SpeechStatistics.speakers_lines_count(speakers_lines)).to eq({'Alf'=>'0'})
      expect { SpeechStatistics.speakers_lines_count(speakers_lines) }.to output("0 Alf\n").to_stdout
    end
  end

end