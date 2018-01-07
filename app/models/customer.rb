class Customer < ApplicationRecord
  has_many :accounts
  belongs_to :branch
  validates :name, :email_id, :phone, :branch_id, presence: true
  # validates :name, uniqueness: {message: "already taken" }
  validates_format_of :email_id, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "is not valid"

  def self.create(cust_attrs)
    customer = Customer.create!(name: cust_attrs[:name], email_id: cust_attrs[:email_id], phone: cust_attrs[:phone], branch_id: cust_attrs[:branch_id], status: true)
  end

  def update(cust_attrs)
    customer = Customer.find(cust_attrs[:id])
    if customer
      self.update_attributes(name: cust_attrs[:name], email_id: cust_attrs[:email_id], phone: cust_attrs[:phone])
    else
      raise ActiveRecord::RecordInvalid
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
