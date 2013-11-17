class Contact

  attr_accessor :first_name, :last_name, :email, :phone

  def initialize(name, email)
    split_name(name)
    @email = email
    @phone = {}
  end

  def to_s
    "#{@first_name} #{@last_name} (#{@email})"
  end

  def display
    puts "------------------------------"
    puts "First name: #{@first_name}"
    puts "Last name: #{@last_name}"
    puts "Email: #{@email}"
    @phone.each { |key, value| puts "#{key}: #{value}" }
    puts "------------------------------"
  end

  def split_name(name)
    name = name.split(" ")
    @first_name = name.first
    @last_name = name.last
  end

end