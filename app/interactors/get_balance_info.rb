class GetBalanceInfo
  include Interactor

  def call
    context.operations = context.user.transactions
                             .filter_by_dates(context.start_date, context.end_date)
                             .order(created_at: :asc)
    context.start_balance = context.operations.first.last_user_balance
    context.end_balance = context.operations.last.last_user_balance + context.operations.last.amount
  end

end