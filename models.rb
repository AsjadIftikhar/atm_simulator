# class UserAccount
#   attr_accessor :balance
#   attr_reader :holder, :expiry_date
#
#   def initialize(holder, atm_number, pin, expiry_date, balance)
#     @holder = holder
#     @atm_number = atm_number
#     @pin = pin
#     @expiry_date = expiry_date
#     @balance = balance
#   end
#
#   def change_pin(old_pin, new_pin)
#     if old_pin == @pin
#       @pin = new_pin
#     else
#       raise StandardError.new "Old Pin Doesn't Match"
#     end
#   end
#
#   def update_profile(name = nil)
#     if name
#       @holder = name
#     end
#
#   end
#
#   def show_balance
#     @balance
#   end
#
#   def with_draw_cash(amount)
#
#   end
# end