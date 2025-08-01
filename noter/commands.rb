require_relative 'config'
include Config

module Commands
  def del_notes(count)
    notes = File.readlines(Config::NOTES_FILE)
    if notes.size == 0
      puts "You are not write any notes yet"
      puts "For write new note use:"
      puts "  note w <your note text>"
      return
    end

    if count.to_i > 0
      notes.delete_at(count.to_i - 1)
    end
    File.open(Config::NOTES_FILE, "w") do |f|
      notes.each do |note|
        f.write note
      end
    end
  end

  def clear_notes
    if File.exist?(Config::NOTES_FILE)
      File.delete(Config::NOTES_FILE)
    end
    puts "All notes was cleared"
  end

  def write_note(note)
    notes = File.exist?(Config::NOTES_FILE)? File.readlines(Config::NOTES_FILE) : []
    File.open(Config::NOTES_FILE, "w") do |f|
      f.puts note
      f.write notes.join()
    end
  end

  def grep_notes(frase)
    notes = File.readlines(Config::NOTES_FILE)
    if notes.size == 0
      return
    end

    filtered = notes.select{|i| i.upcase.include? frase.upcase}
    puts filtered.join()
  end

  def print_notes(count = 0)
    unless File.exist?(Config::NOTES_FILE)
      puts "You are not write any notes yet"
      puts "For write new note use:"
      puts "  note w <your note text>"
      return
    end

    notes = File.readlines(Config::NOTES_FILE).map(&:chomp)
    notes = notes.first(count.to_i) if count.to_i > 0
    puts notes
  end
end 