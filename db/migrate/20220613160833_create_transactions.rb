class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.integer :operation
      t.monetize :amount
      t.monetize :last_user_balance
      t.timestamps
    end
  end
end
