class CreateAccountTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :account_transactions do |t|
      t.integer :to_account
      t.integer :from_account
      t.float :amount, :default => 0.0
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
