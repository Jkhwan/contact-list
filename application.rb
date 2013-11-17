class Application

	def initialize
		@contacts = []
	end

	def run
    show_intro
    loop do
		  show_main_menu
      input = clean_input(gets)
      manage_main_menu_input(input)
      break if input == "quit"
    end
    show_exit_msg
	end

  def manage_main_menu_input(input)
    case input.downcase
    when "new"
      create_contact
    when "list"
      list_contact
    when /\Ashow/
      show_contact(input)
    end
  end

  def manage_edit_menu_input(input, id)
    case input.downcase
    when "edit name"
      edit_name(id)
    when "edit email"
      edit_email(id)
    end
  end

  def edit_name(id)
    @contacts[id].first_name = get_first_name
    @contacts[id].last_name = get_last_name
  end

  def edit_email(id)
    @contacts[id].email = get_email
  end

  def create_contact
    email = get_email
    first_name = get_first_name
    last_name = get_last_name
    full_name = generate_full_name(first_name, last_name)
    @contacts << Contact.new(full_name, email) unless full_name.empty? || email.empty?
  end

  def list_contact
    if @contacts.empty?
      puts "No contacts"
    else
      @contacts.each_with_index { |contact, index| puts "#{index}: #{contact}" }
    end
  end

  def show_contact(input)
    input = input.split(" ")
    if input.count == 1
      puts "Invalid input, must include an id!"
    else
      id = input[1]
      if id.match(/[0-9+]/) && id.to_i < @contacts.count
        @contacts[id.to_i].display
        edit_action(id.to_i)
      else
        puts "Invalid input, must include a valid id!"
      end
    end
  end

  def edit_action(id)
    loop do
      show_edit_menu
      input = clean_input(gets)
      manage_edit_menu_input(input, id)
      break if input == "back"
    end
  end

  def clean_input(input)
    input.chomp.rstrip
  end

  def cap_first_letter(input)
    input[0].upcase + input[1..-1] unless input.empty?
    input ||= ""
  end

  def get_first_name
    print "Enter your first name: "
    clean_input(gets)
  end

  def get_last_name
    print "Enter your last name: "
    clean_input(gets)
  end

  def get_email
    email = ""
    loop do
      print "Enter your email: "
      email = clean_input(gets)
      break unless check_email_duplicate(email)
      puts "Email already exists!"
    end
    email
  end

  def check_email_duplicate(email)
    @contacts.detect { |contact| contact.email == email } ? true : false
  end

  def generate_full_name(first_name, last_name)
    cap_first_letter(first_name) + " " + cap_first_letter(last_name)
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

  def show_edit_menu
    puts " edit name    - Edit name of contact"
    puts " edit email   - Edit email of contact"
    puts " back         - Back to main menu"
    print "> "
  end
end