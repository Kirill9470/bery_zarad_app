require 'rails_helper'

RSpec.describe ChangeBalanceForUser, type: :interactor do

  let(:user) { FactoryBot.create(:user) }

  context "success change balance" do
    it do
      result = ChangeBalanceForUser.call(user: user, amount: 100, operation: 'deposit')
      expect(result.success?).to be_truthy
      expect(user.balance).to eq(Money.new(10000))
    end
  end

  context "failure change balance" do
    it "strategy not found" do
      result = ChangeBalanceForUser.call(user: user, amount: 100, operation: 'some_operation')
      expect(result.success?).to be_falsey
    end

    it "amount less or equal zero" do
      result = ChangeBalanceForUser.call(user: user, amount: 0, operation: 'some_operation')
      expect(result.success?).to be_falsey
    end
  end
end