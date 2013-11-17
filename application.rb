class Application

	def initialize
		@contacts = []
	end

	def run
    show_intro
    loop do
		  show_main_menu
      input = clean_input(gets)
      manage_input(input)
      break if input == "quit"
    end
    show_exit_msg
	end

  def manage_input(input)
    case input.downcase
    when "new"
      create_contact
    end
  end

  def create_contact
    print "Enter your first name: "
    first_name = clean_input(gets)
    print "Enter your last name: "
    last_name = clean_input(gets)
    print "Enter your email: "
    email = clean_input(gets)
    full_name = cap_first_letter(first_name) + " " + cap_first_letter(last_name)
    @contacts << Contact.new(full_name, email) unless full_name.empty? || email.empty?
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
    input.chomp.rstrip
  end

  def cap_first_letter(input)
    input[0].upcase + input[1..-1] unless input.empty?
    input ||= ""
  end
end