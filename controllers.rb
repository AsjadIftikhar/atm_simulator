require 'csv'

class UserAccount
  attr_accessor :balance
  attr_reader :holder, :expiry_date

  def initialize(holder, atm_number, pin, expiry_date, balance)
    @holder = holder
    @atm_number = atm_number
    @pin = pin
    @expiry_date = expiry_date
    @balance = balance
  end

  def authenticate_user?(pin)
    @pin == pin
  end

  def change_pin(old_pin, new_pin)
    if old_pin == @pin
      @pin = new_pin
    else
      raise StandardError.new "Old Pin Doesn't Match"
    end
  end

  def update_profile(name = nil)
    if name
      @holder = name
    end

  end

  def show_balance
    @balance
  end

  def with_draw_cash(amount) end
end

class Machine
  attr_writer :cash_available
  attr_reader :location
  @@count = 0

  def initialize(location, cash_available)
    @id = @@count
    @@count = @@count + 1
    @location = location
    @cash_available = cash_available

    @accounts_db = get_db
    # p @accounts_db
  end

  def get_db
    db = {}
    CSV.read("accounts_db.csv")[1..].each do |user|
      user_account = UserAccount.new(user[0], user[1], user[2], user[3], user[4])
      db.store(user[1], user_account)
    end
    db
  end

  def authenticate
    auth_options = {
      "1. Login" => 1,
      "2. Sign Up" => 2,
      "3. Exit" => 3
    }
    selected = 0
    while selected != 3
      puts auth_options.keys
      selected = gets.chomp.to_i

      if selected == 1
        puts "Enter Account #"
        account_number = gets.chomp
        puts "Enter Pin"
        pin = gets.chomp

        if @accounts_db[account_number] && @accounts_db[account_number].authenticate_user?(pin)
          puts "Logged In Successfully"
        else
          puts "No Matching User Found"
        end

        selected = 3

      elsif selected == 2
        puts "Enter Name"
        holder = gets.chomp
        puts "Enter Pin"
        pin = gets.chomp
        puts "Initial Deposit"
        balance = gets.chomp.to_i

        account_number = rand(10000..99999)

        user = UserAccount.new(holder, account_number, pin, "2030", balance)
        @accounts_db.store(account_number, user)

      end
    end
  end

  def get_options
    options = {
      "1. Create User Account" => 1,
      "2. Update User Account" => 2,
      "3. Delete User Account" => 3,
      "4. Change Pin" => 4,
      "5. Show Balance" => 5,
      "6. With Draw Cash" => 6,
      "7. Log Out" => 7
    }
  end

  def visit_atm
    authenticate
    # options = get_options
    # selected = 0
    # while selected != options["Log Out"]
    #   if selected == 1
    #
    #   elsif selected == 2
    #   elsif selected == 3
    #   elsif selected == 4
    #   elsif selected == 5
    #   elsif selected == 6
    #   end
    # end
  end

end

machine = Machine.new("Gulberg 3", 20000)
machine.authenticate