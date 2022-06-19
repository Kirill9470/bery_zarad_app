class Api::V1::TransactionsController < Api::V1::ApplicationController

  def index
    result = GetBalanceInfo.call(user: @current_user, start_date: params[:start_date], end_date: params[:end_date])

    render json: result.operations,
           each_serializer: TransactionSerializer,
           meta: {
               start_balance: result.start_balance,
               end_balance: result.end_balance
           },
           adapter: :json,
           root: :operations_info,
           status: :ok
  end

end