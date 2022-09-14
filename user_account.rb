class UserAccount
  attr_accessor :balance
  attr_reader :holder, :atm_number, :expiry_date

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
      p "Old Pin Doesn't Match"
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

  def with_draw_cash(amount)
    if @balance.to_i - amount >= 0
      @balance = @balance.to_i - amount
    else
      p "You Do not Have Enough Balance."
    end
  end

  def to_list
    list = [@holder, @atm_number, @pin, @expiry_date, @balance]
  end
end