class Api::V1::UsersController < Api::V1::ApplicationController

  def change_balance
    result = ChangeBalanceForUser.call(user: @current_user,
                                       amount: params[:amount],
                                       operation: params[:operation])

    if result.success?
      render json: { message: t('user.change_balance.success') }, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

end
