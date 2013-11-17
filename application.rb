class Application

	def initialize
		@contacts = []
	end

	def run
		show_main_menu
		input = gets.chomp
	end

	def show_main_menu
		puts "Welcome to the app. What's next?"
		puts " new      - Create a new contact"
    puts " list     - List all contacts"
    puts " show :id - Display contact details"
    print "> "
  end
  
end