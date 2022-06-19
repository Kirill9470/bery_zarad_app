class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :login, index: { unique: true }
      t.monetize :balance,
      t.timestamps
    end
  end
end
