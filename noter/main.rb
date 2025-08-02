require 'colorize'

require_relative 'commands'
require_relative 'config'

module Noter
  def self.usage
    puts "USAGE: note [command] [arguments]\n\n"
    puts "COMMANDS:"
    puts "  write | w [text]    Writes note text into the .notes file"
    puts "  read  | r [n]       Reads [n] notes from the .notes file. If [n] is not specified, reads all notes"
    puts "  grep  | g [word]    Filters notes by the given word"
    puts "  del   | d [n]       Deletes note number [n]"
    puts "  clear               Deletes all notes"
  end

  def self.err(msg)
    puts "\nERR: #{msg}".red
  end

  def self.main
    command = ARGV[0]

    case command
    when "w", "write"
      write_note ARGV[1...ARGV.size].join(" ")
      puts "Note saved to: #{Config::NOTES_FILE}"
    when "r", "read"
      if ARGV.size == 1
        Commands.print_notes
      else
        Commands.print_notes ARGV[1]
      end
    when "g", "grep"
      if ARGV.size == 1
        Commands.print_notes
      else
        Commands.grep_notes ARGV[1...ARGV.size].join(" ")
      end
    when "d", "del"
      if ARGV.size == 1
        usage
        err "You need to specify the number of notes to delete"
      else
        Commands.del_notes ARGV[1]
      end
    when "clear"
      Commands.clear_notes
    when nil
      usage
    else
      usage
      err "Unknown command #{command}"
    end
  end 

  if __FILE__ == $0
    main
  end
end