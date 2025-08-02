require_relative 'config'

module Commands
  def self.del_note(index)
    notes = File.readlines(Config::NOTES_FILE)
    if notes.size == 0
      puts "You haven't written any notes yet"
      puts "To write a new note, use:"
      puts "  note w <your note text>"
      return
    end

    if index.to_i > 0
      notes.delete_at(index.to_i - 1)
    end
    File.open(Config::NOTES_FILE, "w") do |f|
      notes.each do |note|
        f.write note
      end
    end
  end

  def self.clear_notes
    if File.exist?(Config::NOTES_FILE)
      File.delete(Config::NOTES_FILE)
    end
    puts "All notes have been cleared"
  end

  def self.write_note(note)
    notes = File.exist?(Config::NOTES_FILE)? File.readlines(Config::NOTES_FILE) : []
    File.open(Config::NOTES_FILE, "w") do |f|
      f.puts note
      f.write notes.join()
    end
  end

  def self.grep_notes(frase)
    notes = File.readlines(Config::NOTES_FILE)
    if notes.size == 0
      return
    end

    filtered = notes.select{|i| i.upcase.include? frase.upcase}
    puts filtered.join()
  end

  def self.print_notes(count = 0)
    unless File.exist?(Config::NOTES_FILE)
      puts "You haven't written any notes yet"
      puts "To write a new note, use:"
      puts "  note w <your note text>"
      return
    end

    notes = File.readlines(Config::NOTES_FILE).map(&:chomp)
    notes = notes.first(count.to_i) if count.to_i > 0
    notes.each_with_index do |note, i|
      puts "#{i + 1}. #{note}"
    end
  end
end 