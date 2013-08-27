require "rspec"

require_relative "account"

describe Account do
  let(:account) {Account.new('1234567890', 5 )}
  let(:account_bad_number) {Account.new('12345678901', 5 )}
  let(:account_open_balance) {Account.new('1234567890', -5 )}
  let(:account_bad_account_string) {Account.new('abcdefghij', -5 )}
  let(:account_bad_account_data_type) {Account.new(['1','2','3','4','5','6','7','8','9'], -5 )}




  describe "#initialize" do
    it "creates an instance of Account" do
      account.should be_an_instance_of Account 
    end

    it 'should return an exception error for a non 10 digit acct number' do
      expect {account_bad_number}.to raise_error(InvalidAccountNumberError)
    end

    it 'should return an error for a negative opening balance' do
      expect {account_open_balance}.to raise_error(NegativeDepositError)
    end

    it "should return an error if account is not a string of numbers" do
      expect {account_bad_account_string}.to raise_error(InvalidAccountNumberError)
    end

    it "should return an error if account is not a string of numbers" do
      expect {account_bad_account_data_type}.to raise_error(InvalidAccountNumberError)
    end
  end

  describe "#transactions" do
    it 'should return an array of all transactions' do
      account.transactions.should == [0]
    end
  end

  describe "#balance" do
    it 'should return an ongoing balance for account' do
      account.balance.should == 0
    end
  end

  describe "#account_number" do
    it 'should return the acct number for a given Account' do
      account.acct_number.should == '******7890'
    end
  end

  describe "deposit!" do
    it 'should return a exception error for a given Account if neg value' do
      expect {account.deposit!(-15)}.to raise_error(NegativeDepositError)
    end
    
    it 'should return a positive integer deposit amount' do
      account.deposit!(15).should == 15
    end
    
    it 'should allow for a deposit of zero' do
      account.deposit!(0).should == 0
    end
  end

  describe "#withdraw!" do
    it 'should return an error for an accout with a negative balance' do
      expect {account.withdraw!(10)}.to raise_error(OverdraftError)
    end
    it 'should return balance after a withdrawal' do
      account.withdraw!(5).should == 0
    end
    it 'should not allow a withdrawal of a negative amount' do
     account.withdraw!(-5).should == 0
   end
  end
end







