require "rails_helper"

RSpec.describe Account, :type => :model do

  before(:each)do
    branch = Branch.delete_all
    customer = Customer.delete_all
    account = Account.delete_all
    account_transaction = AccountTransaction.delete_all
    @branch = Branch.create!(name: "kormangala Branch")
  end

  it "should create an account" do
    cus = Customer.create(name: "sree1", email_id: "sree1@kre.com", phone: "546543634", branch_id: @branch.id)
    account = Account.create(customer_id: cus.id, balance: 100.0)
    ac = Account.find(account.id)
    expect(ac).to be
    expect(ac.id).to eq account.id
    expect(ac.balance).to eq 100.0
  end

  it "should not create an account if customer is blank" do
    expect {Account.create!(customer_id: nil, balance: 100.0)}.to raise_error ActiveRecord::RecordInvalid
  end

  it "should activate account" do
    cus = Customer.create(name: "sree1", email_id: "sree1@kre.com", phone: "546543634", branch_id: @branch.id)
    account = Account.create!(customer_id: cus.id, balance: 100.0, status: false)
    account.activate()
    expect(account.reload.status).to eq true
  end

  it "should deactivate account" do
    cus = Customer.create(name: "sree2", email_id: "sree2@kre.com", phone: "46356354", branch_id: @branch.id)
    account = Account.create!(customer_id: cus.id, balance: 200.0, status: true)
    account.deactivate()
    expect(account.reload.status).to eq false
  end

  # it "should deposit money to an account for the customer" do
  #   cus = Customer.create(name: "qwerty", email_id: "qwerty@kre.com", phone: "546354", branch_id: @branch.id)
  #   account = Account.create(customer_id: cus.id, balance: 1100.0)
  #   account.account_deposit(balance: 1000.0)
  #   expect(account.reload.balance).to eq(2000.0)
  # end

end