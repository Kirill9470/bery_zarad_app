class TransactionSerializer < ActiveModel::Serializer
  attributes :operation, :created_at, :amount

  def created_at
    object.created_at.strftime('%F')
  end

end