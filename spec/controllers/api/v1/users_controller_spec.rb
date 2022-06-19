require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_token) { JWT.encode({login: user.login}, ENV['SECRET_KEY']) }

  before do
    request.headers['Authorization'] = valid_token
  end

  describe 'PUT change_balance' do
    it "returns a ok" do
      allow(ChangeBalanceForUser).to receive(:call) do
        double('Interactor::Context', success?: true, error: nil)
      end

      put :change_balance, params: {id: user.id}
      expect(response).to have_http_status(:ok)
    end

    it "returns a unprocessable_entity" do
      allow(ChangeBalanceForUser).to receive(:call) do
        double('Interactor::Context', success?: false, error: I18n.t('user.change_balance.failed'))
      end

      put :change_balance, params: {id: user.id}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end