class Application

	def initialize
		@contacts = []
	end

	def run
    show_intro
    read_from_csv
    loop do
		  show_main_menu
      input = clean_input(gets)
      manage_main_menu_input(input)
      break if input == "quit"
    end
    write_to_csv
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
    when /\Afind/
      find_contact(input)
    when "quit"
    else
      puts "Invalid input!"
    end
  end

  def manage_edit_menu_input(input, id)
    case input.downcase
    when "edit name"
      edit_name(id)
    when "edit email"
      edit_email(id)
    when "add phone"
      add_phone(id)
    when "back"
    else
      puts "Invalid input!"
    end
  end

  def edit_name(id)
    @contacts[id].first_name = get_first_name
    @contacts[id].last_name = get_last_name
  end

  def edit_email(id)
    @contacts[id].email = get_email
  end

  def add_phone(id)
    phone_number = get_phone_number
    phone_label = get_phone_label
    @contacts[id].phone[phone_label] = phone_number
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
        edit_action(id.to_i)
      else
        puts "Invalid input, must include a valid id!"
      end
    end
  end

  def find_contact(input)
    input = input.split(" ")
    if input.count == 1
      puts "Invalid input, must include a search term!"
    else
      term = input[1]
      found = @contacts.select do |contact|
                phone = contact.phone.select { |key, value| value.include?(term) }
                phone.count > 0 || contact.first_name.downcase.include?(term.downcase) || 
                contact.last_name.downcase.include?(term.downcase) || contact.email.downcase.include?(term.downcase)
              end
      if found.empty?
        puts "Not found!"
      else
        found.each { |x| x.display }
      end
    end    
  end

  def edit_action(id)
    loop do
      @contacts[id.to_i].display
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
    input = input[0].upcase + input[1..-1] unless input.empty?
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

  def get_phone_number
    print "Enter your phone number: "
    clean_input(gets)
  end

  def get_phone_label
    print "Enter a label: "
    cap_first_letter(clean_input(gets))
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
    puts " new         - Create a new contact"
    puts " list        - List all contacts"
    puts " find :term  - Find a contact using search term"
    puts " show :id    - Display contact details"
    puts " quit        - Quit the program"
    print "> "
  end

  def show_edit_menu
    puts " add phone    - Add phone numbers to contact"
    puts " edit name    - Edit name of contact"
    puts " edit email   - Edit email of contact"
    puts " back         - Back to main menu"
    print "> "
  end

  def write_to_csv
    CSV.open("contact.csv", "wb") do |csv|
      @contacts.each_with_index do |contact, index|  
        newArray = []
        newArray << index << contact.first_name << contact.last_name << contact.email
        csv << newArray
      end
    end

    CSV.open("phone.csv", "wb") do |csv|
      @contacts.each_with_index do |contact, index|  
        unless contact.phone.empty?
          contact.phone.each do |key, value|
            newArray = []
            newArray << index << key << value
            csv << newArray
          end
        end
      end
    end   
  end

  def read_from_csv
    begin
      CSV.foreach("contact.csv") do |row|
        full_name = generate_full_name(row[1], row[2])
        email = row[3]
        @contacts << Contact.new(full_name, email)
      end
      CSV.foreach("phone.csv") do |row|
        id = row[0].to_i
        label = row[1]
        @contacts[id].phone[label] = row[2]
      end
    rescue
    end
  end

end