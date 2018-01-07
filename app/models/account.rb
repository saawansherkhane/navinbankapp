class Account < ApplicationRecord
  belongs_to :customer
  has_many :account_transactions
  validates :customer_id, presence: true

  def self.create(account_attrs)
    customer = Customer.find(account_attrs[:customer_id])
    if customer
      account = Account.create!(customer_id: customer.id, balance: account_attrs[:balance], status: true)
      account_transaction = AccountTransaction.create!(account_id: account.id, amount: account.balance, to_account: account.id, from_account: account.id)
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def transfer(acc_attrs)
    Account.transaction do
      account = Account.find(acc_attrs[:to_account])
      AccountTransaction.create!(account_id: self.id, amount: acc_attrs[:balance], description: "Transfered #{acc_attrs[:balance]} to #{account.id}", to_account: account.id, from_account: self.id)
      AccountTransaction.create!(account_id: account.id, amount: acc_attrs[:balance], description: "Credited Amount #{acc_attrs[:balance]} from  #{self.id}", to_account: account.id, from_account: self.id)
      account.update_attribute(:balance,self.balance + acc_attrs[:balance])
      update_attribute(:balance, self.balance - acc_attrs[:balance])
    end
  end

  def withdraw(acc_attrs)
    Account.transaction do
      AccountTransaction.create!(account_id: self.id, amount: acc_attrs[:balance], description: "Debited Amount #{acc_attrs[:balance]} to #{self.id}", to_account: self.id, from_account: self.id)
      update_attribute(:balance, self.balance - acc_attrs[:balance])
    end
  end

  def account_deposit(acc_attrs)
    Account.transaction do
      AccountTransaction.create!(account_id: self.id, amount: acc_attrs[:balance], description: "Credited Amount #{acc_attrs[:balance]} to #{self.id}", to_account: self.id, from_account: self.id)
      update_attribute(:balance, self.balance + acc_attrs[:balance])
    end
  end

  def activate()
    if !self.status?
      update_attribute(:status, true)
    else
      raise ActiveRecord::RecordInvalid
    end
  end

  def deactivate()
    if self.status?
      update_attribute(:status, false)
    else
      raise ActiveRecord::RecordInvalid
    end
  end

end