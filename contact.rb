class Contact

  attr_accessor :first_name, :last_name, :email

  def initialize(name, email)
    split_name(name)
    @email = email
  end

  def to_s
    "#{@first_name} #{@last_name} (#{@email})"
  end

  def display
    puts "First name: #{@first_name}"
    puts "Last name: #{@last_name}"
    puts "Email: #{@email}"
  end

  def split_name(name)
    name = name.split(" ")
    @first_name = name.first
    @last_name = name.last
  end

end