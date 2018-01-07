class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email_id
      t.integer :phone
      t.references :branch, foreign_key: true

      t.timestamps
    end
  end
end
