require "./lib/enigma.rb"

def get_help
  puts "Wrong number of arguments. Example:\n\n$ ruby ./lib/encrypt.rb message.txt encrypted.txt\n\n'message.txt' must already exist.\n'encrypted.txt' will be (over)written."
end

get_help unless ARGV.size == 2; exit unless ARGV.size == 2

message_input, encrypted_output = ARGV

message = File.open(message_input, "r").readlines.join

enigma = Enigma.new

message_output, key_output, date_output = enigma.encrypt(message).values

encrypted_message = File.open(encrypted_output, "w")
encrypted_message.write message_output
encrypted_message.close

puts "Created #{encrypted_output} with the key #{key_output} and date #{date_output}"
