require 'csv'

require_relative 'user_account'
require_relative 'db'

class Machine
  attr_writer :cash_available
  attr_reader :location
  @@count = 0

  def initialize(location, cash_available)
    @id = @@count
    @@count = @@count + 1
    @location = location
    @cash_available = cash_available

    @accounts_db = AccountDB.new
    @current_user = nil
  end

  def authenticate
    auth_options = {
      "1. Login" => 1,
      "2. Sign Up" => 2,
      "3. Exit" => 3
    }
    selected = 0
    while selected < 3
      puts auth_options.keys
      selected = gets.chomp.to_i

      if selected == 1
        puts "Enter Account #"
        account_number = gets.chomp
        puts "Enter Pin"
        pin = gets.chomp

        current_user = @accounts_db.get_from_db(account_number)
        if current_user && current_user.authenticate_user?(pin)
          @current_user = current_user
          puts "Logged In Successfully"
        else
          puts "No Matching User Found"
        end

        selected = 4

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

        # Write back to CSV Here!
      end
    end
    selected
  end

  def perform_action
    options = {
      "1. Update User Account" => 1,
      "2. Delete User Account" => 2,
      "3. Change Pin" => 3,
      "4. Show Balance" => 4,
      "5. With Draw Cash" => 5,
      "6. Log Out" => 6
    }

    selected = 0
    while selected != 6
      puts options.keys
      selected = gets.chomp.to_i

      if selected == 1
        puts "Enter Name"
        holder = gets.chomp

        # Save CSV here!

      elsif selected == 2
      elsif selected == 3
        puts "Enter Old Pin"
        old_pin = gets.chomp

        puts "Enter New Pin"
        new_pin = gets.chomp

        @current_user.change_pin(old_pin, new_pin)
        # Update DB Here!
      elsif selected == 4
        puts "You Current Balance is #{@current_user.show_balance}"

      elsif selected == 5
        puts "Enter Amount"
        amount = gets.chomp.to_i

        if @cash_available >= amount
          @current_user.with_draw_cash(amount)
        else
          p "ATM machine is out of cash."
        end
      end
    end
  end

  def visit_atm
    selected = authenticate
    perform_action if selected != 3

  end

end

machine = Machine.new("Gulberg 3", 20000)
machine.visit_atm