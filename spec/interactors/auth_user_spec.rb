require 'rails_helper'

RSpec.describe AuthUser, type: :interactor do

  let!(:user) { FactoryBot.create(:user) }

  let(:valid_token) { JWT.encode({login: user.login}, ENV['SECRET_KEY']) }
  let(:nil_token) {nil}
  let(:not_found_user_token) { JWT.encode({login: 'test11@test.com'}, ENV['SECRET_KEY']) }

  let(:success_result) {AuthUser.call(token: valid_token)}
  let(:nil_token_result) {AuthUser.call(token: nil_token)}
  let(:not_found_user_token_result) {AuthUser.call(token: not_found_user_token)}

  context "success auth" do
    it do
      expect(success_result.success?).to be_truthy
      expect(success_result.user.id).to eq(user.id)
    end
  end

  context "failure auth" do
    it "decode error" do
      expect(nil_token_result.success?).to be_falsey
    end

    it "user not found" do
      expect(not_found_user_token_result.success?).to be_falsey
    end
  end
end