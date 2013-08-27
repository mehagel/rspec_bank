require "rspec"

require_relative "account"

describe Account do
  let(:account) {Account.new('1234567890', 5 )}


  describe "#initialize" do
    it "creates an instance of Account" do
      account.should be_an_instance_of Account 
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

  end
end
