require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_token) { JWT.encode({login: user.login}, ENV['SECRET_KEY']) }

  before do
    request.headers['Authorization'] = valid_token
  end

  describe 'GET index' do
    it "returns a ok" do
      allow(GetBalanceInfo).to receive(:call) do
        double('Interactor::Context', success?: true, error: nil, operations: [], start_balance: 0, end_balance: 0)
      end

      get :index, params: {}
      expect(response).to have_http_status(:ok)
    end
  end
end