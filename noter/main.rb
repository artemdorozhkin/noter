require 'colorize'

require_relative 'commands'
include Commands
require_relative 'config'
include Config

def usage
  puts "USAGE: note [command] [arguments]\n\n"
  puts "COMMANDS:"
  puts "  write | w [text]\twrites note text into .notes file"
  puts "  read  | r [n]\t\tread [n] notes from .notes file. If [n] not specified, readings all notes"
  puts "  grep  | g [word]\tfiltered notes by word"
  puts "  del   | d [n]\t\tdeletes [n] note"
  puts "  clear\t\t\tclear all notes"
end

def err(msg)
  puts "\nERR: #{msg}".red
end

def main
  command = ARGV[0]
  
  case command
  when "w", "write"
    write_note ARGV[1...ARGV.size].join(" ")
    puts "note saved into: #{Config::NOTES_FILE}"
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
      err "you need to specify number of notes to delete"
    else
      Commands.del_notes ARGV[1]
    end
  when "clear"
    Commands.clear_notes
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