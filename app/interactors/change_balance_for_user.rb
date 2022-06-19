class ChangeBalanceForUser
  include Interactor

  before :validate_operation, :validate_amount

  def call
    result = context.user.__send__(context.operation, context.amount.to_d)
    context.fail!(error: I18n.t('user.change_balance.failed')) unless result
  end

  private

  def validate_operation
    result = Transaction.operations.keys.include?(context.operation)
    context.fail!(error: I18n.t('user.change_balance.operation_not_found')) unless result
  end

  def validate_amount
    context.fail!(error: I18n.t('user.change_balance.amount_is_greater_than_zero')) if context.amount.to_d <= 0
  end

end