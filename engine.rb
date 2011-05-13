require File.join(File.dirname(__FILE__), 'avatar')
require File.join(File.dirname(__FILE__), 'room')
require File.join(File.dirname(__FILE__), 'input_controller')
require File.join(File.dirname(__FILE__), 'game_data_loader')

location_data_file = File.absolute_path(File.join(File.dirname(__FILE__), "#{ARGV[0]}"))
message_data_file = File.absolute_path(File.join(File.dirname(__FILE__), "#{ARGV[1]}"))

ARGV.clear

loader = GameDataLoader.new
locations = loader.load_location_data(location_data_file)
messages = loader.load_message_data(message_data_file)
lake = locations.find {|location| location.starting_location?} 

# Initializing controller
avatar = Avatar.new(lake)
ctl = InputController.new
ctl.messages = messages
ctl.avatar = avatar
ctl.initialize_message

def repl(ctl)
	puts ctl.current_message
	puts 
	print "> "
	input = gets.chomp
	ctl.evaluate(input)
	repl(ctl)
end

# Print splash
puts messages["splash"]
# Set up the game loop
repl(ctl)
	
