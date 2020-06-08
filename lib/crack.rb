require "./lib/enigma.rb"

encrypted_input, cracked_ouput, date_input = ARGV

encrypted_message = File.open(encrypted_input, "r").readlines.join

enigma = Enigma.new

message_output, date_output, key_output = enigma.crack(encrypted_message, date_input).values

cracked_message = File.open(cracked_ouput, "w")
cracked_message.write message_output
cracked_message.close

puts "Created #{cracked_ouput} with the key #{key_output} and date #{date_output}"
