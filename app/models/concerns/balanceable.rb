module Balanceable
  extend ActiveSupport::Concern

  included do
    has_many :transactions

    monetize :balance_cents

    def withdrawal(amount)
      determine_balance(-amount, 'withdraw')
    end

    def deposit(amount)
      determine_balance(amount, 'deposit')
    end

    private

    def determine_balance(amount, operation)
      logger.debug "[#{self.class.name}.transaction] amount: #{amount}, operable: #{operation}, balance:#{balance}"
      transaction do
        trn = transactions.create(amount: amount, operation: operation, last_user_balance: balance)
        update(balance: balance + trn.amount)
      end
      true
    rescue ActiveRecord::RecordInvalid => exception
      logger.fatal "#{exception}"
      false
    end
  end

end