class Account
  attr_reader :transactions

  def initialize(acct_number, starting_balance = 0)
    validate_account(acct_number)
    validate_amount(starting_balance)

    @acct_number  = acct_number
    @transactions = [ starting_balance ]
  end

  def balance
    transactions.inject(:+)
  end

  def acct_number
    hidden_length = @acct_number.length - 4
    @acct_number.sub(Regexp.new("^.{#{hidden_length}}"), "*" * hidden_length)
  end

  def deposit!(amount) 
    validate_amount(amount)
    add_transaction(amount)

    balance
  end

  def withdraw!(amount)
    amount = -amount if amount > 0
    add_transaction(amount)

    balance
  end

private

  def validate_account(number)
    unless number.class == String && valid_number?(number) 
      raise InvalidAccountNumberError
    end
  end

  def validate_amount(amount)
   raise NegativeDepositError if amount < 0 
  end

  def valid_number?(number)
    number.match /^\d{10}$/
  end

  def add_transaction(amount)
    raise OverdraftError if balance + amount < 0
    transactions << amount

    self
  end
end

class InvalidAccountNumberError < StandardError; end
class NegativeDepositError < StandardError; end
class OverdraftError < StandardError; end
