require 'rails_helper'

RSpec.describe GetBalanceInfo, type: :interactor do

  let(:user) { FactoryBot.create(:user) }

  context "success get balance info" do
    it do
      5.times do
        user.deposit(100)
      end

      5.times do
        user.withdrawal(50)
      end

      trs = Transaction.limit(2)
      trs.update_all(created_at: DateTime.parse('2020-03-31 00:00:00'))

      result = GetBalanceInfo.call(user: user,
                                   start_date: Time.current.beginning_of_day.strftime('%d.%m.%Y %H:%M'),
                                   end_date: Time.current.end_of_day.strftime('%d.%m.%Y %H:%M'))
      expect(result.success?).to be_truthy
      expect(result.operations.count).to eq(8)
      expect(result.start_balance).to be > Money.new(0)
      expect(result.end_balance).to be > Money.new(0)
    end
  end

end