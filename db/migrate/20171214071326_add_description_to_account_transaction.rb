class AddDescriptionToAccountTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :account_transactions, :description, :text
  end
end
