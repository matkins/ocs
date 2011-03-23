require 'enumerator'

String.class_eval do

  def split_with_index(regex)
    ret = []
    index_offset = 0
    remaining_text = dup
    split(regex).each do |word|
      ret << [word,remaining_text.index(word) + index_offset]
      cutoff = remaining_text.index(word) + word.length
      remaining_text.slice!(0..cutoff)
      index_offset += cutoff + 1
    end
    ret
  end
end

class Osc2Html
  
  class << self
    def chordify(chords, words)
      chord_line, word_line = "", ""
      pointer = 0
      chords.split_with_index(' ').each do |chord, index|
        chord_line << "<td>#{chord}</td>"
        word_line << "<td>#{words[pointer..index]}</td>"
        pointer = index + 1
      end
      puts "<tr>#{chord_line}</tr><tr>#{word_line}</tr>"
    end
  end 
  
end


lines = File.open("cross.osc", "r").readlines
lines.each_slice(2) do |chords, words|
  puts "#{Osc2Html::chordify(chords, words)}"
end