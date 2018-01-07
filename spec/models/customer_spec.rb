require 'rails_helper'

RSpec.describe Customer, type: :model do

  before(:each)do
    branch = Branch.delete_all
    customer = Customer.delete_all
    account = Account.delete_all
    @branch = Branch.create!(name: "kormangala Branch")
  end

  it "should not create a customer if name is not present" do
    expect {Customer.create(name: nil, email_id: "karthik@gmail.com", phone: "43564656", branch_id: @branch.id)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should not create a customer if email is incorrect" do
    cust = {name: "kra", email_id: "kra@.com", phone: "678768", branch_id: @branch.id}
    expect {Customer.create(cust)}.to raise_error ActiveRecord::RecordInvalid
  end

  it "should not create a customer if phone number is blank" do
    cust = {name: "vaidi", email_id: "vaidi@kre.com", phone: nil, branch_id: @branch.id}
    expect {Customer.create(cust)}.to raise_error ActiveRecord::RecordInvalid
  end

  it "should not create a customer if branch is blank" do
    cust = {name: "mouli", email_id: "mouli@kre.com", phone: "2342325", branch_id: nil}
    expect {Customer.create(cust)}.to raise_error ActiveRecord::RecordInvalid
  end

  # it "should not create a customer if name is already taken" do
  #   cust = Customer.create!(name: "saawan", email_id: "kar@kreatio.com", phone: "8963748", branch_id: @branch.id)
  #
  #   cust1 = {name: cust.name, email_id: "kar@kreatio.com", phone: "8963748", branch_id: @branch.id}
  #   expect {Customer.create(cust1)}.to raise_error ActiveRecord::RecordInvalid
  # end

  it "should activate customer" do
    customer = Customer.create!(name: "tnapp", email_id: "tnapp@gmail.com", phone: "46564563", branch_id: @branch.id, status: false)
    customer.activate()
    expect(customer.reload.status).to eq true
  end

  it "should deactivate customer" do
    customer = Customer.create(name: "tnavinapp", email_id: "tnavinapp@gmail.com", phone: "576546", branch_id: @branch.id)
    customer.deactivate()
    expect(customer.reload.status).to eq false
  end

end
