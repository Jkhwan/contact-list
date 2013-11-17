class Application

	def initialize
		@contacts = []
	end

	def run
    show_intro
    loop do
		  show_main_menu
      input = clean_input(gets)
      break if input == "quit"
    end
    show_exit_msg
	end

  def show_intro
    puts "Welcome to the app. What's next?"
  end

  def show_exit_msg
    puts "Adeu!"
  end

	def show_main_menu
		puts " new      - Create a new contact"
    puts " list     - List all contacts"
    puts " show :id - Display contact details"
    puts " quit     - Quit the program"
    print "> "
  end

  def clean_input(input)
    input.chomp.rstrip.downcase
  end

end