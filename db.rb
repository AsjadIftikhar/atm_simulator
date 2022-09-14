class AccountDB

  def initialize
    @db = get_db
  end

  def get_db
    db = {}
    CSV.read("accounts_db.csv")[1..].each do |user|
      user_account = UserAccount.new(user[0], user[1], user[2], user[3], user[4])
      db.store(user[1], user_account)
    end
    db
  end

  def get_from_db(atm_number)
    @db[atm_number]
  end

  def update_db

  end

  def delete_from_db(atm_number)
    @db.delete(atm_number)
    p @db
  end
end
