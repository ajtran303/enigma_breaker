# $ ruby ./lib/crack.rb encrypted.txt cracked.txt 070620

require "./lib/enigma.rb"

encrypted_input, cracked_ouput, date_input = ARGV

encrypted_message = File.open(encrypted_input, "r").readlines.join

enigma = Enigma.new

message_output, date_output, key_output = enigma.crack(encrypted_message, date_input).values

decrypted_message = File.open(cracked_ouput, "w")
decrypted_message.write message_output
decrypted_message.close

puts "Created #{cracked_ouput} with the key #{key_output} and date #{date_output}"
# expecting key "82000" date "070620"
