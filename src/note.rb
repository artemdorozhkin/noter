require 'colorize'

NOTES_FILE = ".notes"

def usage
  puts "note [command] [arguments]\n\n"
  puts "  write | w [text]\twrites note text into .notes file"
  puts "  read  | r [n]\t\tread [n] notes from .notes file. If [n] not specified, readings all notes"
  puts "  gred  | g [word]\t\tfiltered notes by word"
  puts "  del   | d [n]\t\tdeletes [n] note"
  puts "  clear\t\t\tclear all notes"
end

def err(msg)
  puts "\nERR: #{msg}".red
end

def del_notes(count)
  notes = File.readlines(NOTES_FILE)
  if notes.size == 0
    puts "You are not write any notes yet"
    puts "For write new note use:"
    puts "  note w <your note text>"
    return
  end

  if count.to_i > 0
    notes.delete_at(count.to_i - 1)
  end
  File.open(NOTES_FILE, "w") do |f|
    notes.each do |note|
      f.write note
    end
  end
end

def clear_notes
  if File.exist?(NOTES_FILE)
    File.delete(NOTES_FILE)
  end
  puts "All notes was cleared"
end

def write_note(note)
  File.open(NOTES_FILE, "a") do |f|
    f.write("#{note}\n")
  end
end

def grep_notes(frase)
  notes = File.readlines(NOTES_FILE)
  if notes.size == 0
    return
  end
  
  filtered = notes.select{|i| i.upcase.include? frase.upcase}
  puts filtered.join()
end

def print_notes(count = 0)
  unless File.exist?(NOTES_FILE)
    puts "You are not write any notes yet"
    puts "For write new note use:"
    puts "  note w <your note text>"
    return
  end

  notes = File.readlines(NOTES_FILE).map(&:chomp)
  notes = notes.first(count.to_i) if count.to_i > 0
  puts notes
end

def main
  command = ARGV[0]
  
  case command
  when "w", "write"
    write_note ARGV[1...ARGV.size].join(" ")
    puts "note saved into: #{NOTES_FILE}"
  when "r", "read"
    if ARGV.size == 1
      print_notes
    else
      print_notes ARGV[1]
    end
  when "g", "grep"
    if ARGV.size == 1
      print_notes
    else
      grep_notes ARGV[1...ARGV.size].join(" ")
    end
  when "d", "del"
    if ARGV.size == 1
      usage
      err "you need to specify number of notes to delete"
    else
      del_notes ARGV[1]
    end
  when "clear"
    clear_notes
  when nil
    usage
  else
    usage
    err "unknown command #{command}"
  end
end 

if __FILE__ == $0
  main
end