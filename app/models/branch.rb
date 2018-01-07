class Branch < ApplicationRecord
  has_many :customers
  validates :name, presence: true
  validates :name, uniqueness: {message: "already taken" }

  def self.create(branch_attrs)
    branch = Branch.create!(name: branch_attrs[:name])
  end

end
