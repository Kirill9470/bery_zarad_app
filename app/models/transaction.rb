class Transaction < ApplicationRecord
  include Searchable

  belongs_to :user

  monetize :amount_cents, :last_user_balance_cents

  enum operation: {
      withdraw: 0,
      deposit: 1
  }
end
