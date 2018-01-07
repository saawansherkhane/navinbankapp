class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.float :balance, :default => 0.0
      t.references :customer, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
