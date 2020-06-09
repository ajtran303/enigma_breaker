# Enigma Breaker

Final independent project for Mod1 BEE Program at the Turing School of Software and Design.

This program can encrypt and decrypt secret messages with keys and crack them when no keys are given. It can be used on the command line and in a REPL environment.

## Get started

Clone down this repo and `cd` into the directory.

### Command Line Interface

The CLI will require an existing text file to encrypt. I recommend ending the transmission with the keyword ` end` if you would like to try the cracking feature.

**Important!** All of the following command prompts will generate a new text file.

```
$ cat > message.txt
Hello world! end
  -- control-d --
```

First, encrypt the message. Take note of the key and date of transmission!

```
$ ruby ./lib/encrypt.rb message.txt encrypted.txt
Created 'encrypted.txt' with the key 82648 and date 240818
```

You can decrypt a message with its key and date of transmission.

```
$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818
Created 'decrypted.txt' with the key 82648 and date 240818
```

A message and its key can be cracked with only the date of transmission.

**Important!** For a message to be cracked, it must end in `" end"` !

```
$ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
Created 'cracked.txt' with the cracked key 82648 and date 240818
```

### REPL Interface

Enigma has robust input validation for REPL interaction. Please experiment with different inputs! You can help me by reporting bugs [in the issues section of this repo](https://github.com/ajtran303/enigma_breaker/issues/new).

```ruby
$ pry
pry(main)> require 'date'
pry(main)> require './lib/enigma'
pry(main)> enigma = Enigma.new

# encrypt a message with a key and date
pry(main)> enigma.encrypt("hello world", "02715", "040895")

# decrypt a message with a key and date
pry(main) > enigma.decrypt("keder ohulw", "02715", "040895")

# encrypt a message with a key (uses today's date)
pry(main)> encrypted = enigma.encrypt("hello world", "02715")

# decrypt a message with a key (uses today's date)
pry(main) > enigma.decrypt(encrypted[:encryption], "02715")

# encrypt a message (generates random key and uses today's date)
pry(main)> enigma.encrypt("hello world")

# a message must terminate in " end" in order to be cracked!
pry(main)> enigma.encrypt("hello world end", "08304", "291018")

# crack an encryption with a date
pry(main)> enigma.crack("vjqtbeaweqihssi", "291018")

# crack an encryption (uses today's date)
pry(main)> enigma.crack("vjqtbeaweqihssi")
```

#### Self-assessment

The following assessment is based on the [rubric](https://backend.turing.io/module1/projects/enigma/rubric) of five categories.

**4 - Functionality**

The cracking method and command line interface are successfully implemented. It includes a robust data validation scheme for the user interface.

**4 - Object Oriented Programming**

I can shortly detail the Single Responsibilities of all of my classes:

Enigma takes user input to `encrypt` `decrypt` or `crack` a `secret_message`.

Tokenizer takes a message from Enigma and passes it on as `tokens` to the CipherEngine.

Gear takes values to find `shifts` to give to the CipherEngine.

CipherEngine receives tokens and shifts to `get_encryption` or `get_decryption`.

Rotator is like a secret-decoder ring. It can `get_rotations` of the alphabet.

Imagine that CipherEngine uses rotations from four secret-decoder rings to `compile` a secret message!

That is what happens to the secret message returned to Enigma to output to the user!

Sequenceable is a Module for making, accessing, and calculating sequences. It makes the code more readable -- since almost every class has to do something with a sequence, it can get the method from the Sequenceable.

I tried two times to implement Inheritance but then ultimately chose not to for several reasons.

Originally, the CipherEngine was two separate classes - the only difference was the direction of their rotations. I was going to compose a super class for them. Then I thought, "Why have two Engines that rotate separate ways, when I can have one Engine that rotates both ways?" This made my program more simple because then I had one solid class instead of three wishy classes.

I thought that `Tokenizer` and `Rotator` could have a `Sequencer` super class because they both initialize with the same state. I successfully implemented the Inheritance, but then found out that I may have been violating the Liskov Substitution Principle. The Sequencer super class didn't really do anything so I removed it.

**4 - Ruby Conventions and Mechanics**

I refactored my program while referencing the [Ruby style guide](https://github.com/rubocop-hq/ruby-style-guide). My code demonstrates knowledge of Ruby mechanics. I don't want to undersell myself -- you have to go look and see! I learned some pretty neat tricks for this project, like splat operators and array destructuring. Like I said, you'll have to go and see!

**4 - Test Driven Development**

Test coverage metrics show 100% coverage! I used some stubs to force specific return values for testing randomly generated values and the current date. I did use some modules into my tests -- I'm not sure if that was right but it was fun and I think it worked.

**3 - Version Control**

I need to continue developing my version control workflow and commit when single features have complete functionality.
